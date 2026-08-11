import { Kafka, Producer } from 'kafkajs';

export class KafkaService {
  private producer: Producer;
  private brokers: string[];

  constructor() {
    const brokersEnv = process.env.KAFKA_BROKERS || 'localhost:9092';
    this.brokers = brokersEnv.split(',');
    const kafka = new Kafka({ brokers: this.brokers });
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
