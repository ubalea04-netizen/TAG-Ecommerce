Indexer service

Lightweight Kafka consumer for MVP that listens to `product.events` and `auction.events` and writes them to `events/<topic>.ndjson`.

Run locally (requires Kafka):

```bash
cd backend
# start Kafka in your dev infra (not provided here)
cd services/indexer
npm install
npm run start:dev
```

Configure `KAFKA_BROKERS` in the environment if needed.
