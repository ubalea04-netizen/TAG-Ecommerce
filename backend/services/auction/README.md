Auction service (minimal)

Endpoints:
- POST `/auctions/:id/bids` place bid { bidderId, amount }
- GET `/auctions/:id` get auction
- GET `/auctions/:id/bids` list bids

Run locally (requires backend docker-compose):

```bash
cd backend
docker-compose up -d
cd services/auction
npm install
npx prisma generate
npm run start:dev
```
