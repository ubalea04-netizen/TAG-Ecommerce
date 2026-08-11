import { NestFactory } from '@nestjs/core';
import { Module } from '@nestjs/common';
import { OrderController } from './order.controller';
import { OrderService } from './order.service';
import { PrismaService } from './prisma.service';

@Module({
  controllers: [OrderController],
  providers: [OrderService, PrismaService],
})
class AppModule {}

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const port = process.env.PORT || 3004;
  await app.listen(port);
  console.log('Order service listening on', port);
}

bootstrap();
