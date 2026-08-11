Payment service (minimal)

Endpoints:
- POST `/payments/intents` create payment intent { amount, currency }
- POST `/payments/{id}/capture` capture payment

This implementation stores intents in the DB and simulates capture. Replace gateway calls with Stripe/Razorpay adapters for production.

Run:

```bash
cd backend
docker-compose up -d
cd services/payment
npm install
npx prisma generate
npm run start:dev
```
