import { Module } from '@nestjs/common';
import { AuctionController } from './auction.controller';
import { AuctionService } from './auction.service';
import { PrismaService } from './prisma.service';

@Module({
  controllers: [AuctionController],
  providers: [AuctionService, PrismaService],
})
export class AppModule {}
