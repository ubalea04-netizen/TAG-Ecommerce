import { Kafka } from 'kafkajs';
import { mkdir, appendFile } from 'fs/promises';
import { join } from 'path';

const brokers = (process.env.KAFKA_BROKERS || 'localhost:9092').split(',');
const topics = ['product.events', 'auction.events'];
const outDir = process.env.INDEXER_OUTPUT_DIR || 'events';

async function ensureOut() {
  await mkdir(outDir, { recursive: true });
}

async function run() {
  await ensureOut();
  const kafka = new Kafka({ brokers });
  const consumer = kafka.consumer({ groupId: 'indexer-group' });
  await consumer.connect();
  for (const t of topics) await consumer.subscribe({ topic: t, fromBeginning: true });

  console.log('Indexer connected, listening to topics:', topics);

  await consumer.run({
    eachMessage: async ({ topic, partition, message }) => {
      try {
        const value = message.value?.toString() || '';
        const record = { topic, partition, offset: message.offset, timestamp: Date.now(), value: JSON.parse(value) };
        const line = JSON.stringify(record) + '\n';
        const file = join(outDir, `${topic}.ndjson`);
        await appendFile(file, line);
        console.log(`Appended message to ${file}`);
      } catch (e) {
        console.error('Failed to process message', e);
      }
    },
  });
}

run().catch((e) => {
  console.error('Indexer failed', e);
  process.exit(1);
});
