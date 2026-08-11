Backend monorepo (NestJS + Prisma) scaffold for MVP services.

Quick start (local dev requires Docker):

1. Start dev infra:

```bash
cd backend
docker-compose up -d
```

2. Install and generate clients:

```bash
npm install
npx prisma generate
```

3. Run individual services:

```bash
cd services/auth
npm install
npm run start:dev
```

See each service folder for details.
