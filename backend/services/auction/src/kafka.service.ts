import { Kafka, Producer } from 'kafkajs';

export class KafkaService {
  private producer: Producer;

  constructor() {
    const brokersEnv = process.env.KAFKA_BROKERS || 'localhost:9092';
    const brokers = brokersEnv.split(',');
    const kafka = new Kafka({ brokers });
    this.producer = kafka.producer();
    this.connect().catch((e) => console.error('kafka connect error', e));
  }

  private async connect() {
    await this.producer.connect();
  }

  async send(topic: string, message: any) {
    try {
      await this.producer.send({ topic, messages: [{ value: JSON.stringify(message) }] });
    } catch (e) {
      console.error('kafka send failed', e);
    }
  }
}

export const kafkaService = new KafkaService();
