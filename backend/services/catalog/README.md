Catalog service (NestJS + Prisma)

Endpoints:
- POST `/products` create product
- GET `/products` list products
- GET `/products/:id` get product
- POST `/products/:id/inventory/reserve` reserve inventory

Run:

```bash
cd backend
docker-compose up -d
cd services/catalog
npm install
npx prisma generate
npm run start:dev
```
