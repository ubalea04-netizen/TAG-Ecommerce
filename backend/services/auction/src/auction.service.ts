import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from './prisma.service';
import Redis from 'ioredis';
import { kafkaService } from './kafka.service';

@Injectable()
export class AuctionService {
  private redis: Redis;
  constructor(private prisma: PrismaService) {
    this.redis = new Redis(process.env.REDIS_URL || 'redis://localhost:6379');
  }

  async placeBid(auctionId: string, bidderId: string, amount: number) {
    const lockKey = `auction-lock:${auctionId}`;
    const locked = await this.redis.set(lockKey, '1', 'NX', 'PX', 5000);
    if (!locked) throw new BadRequestException('Auction busy, try again');

    try {
      return await this.prisma.$transaction(async (tx) => {
        const auction = await tx.auction.findUnique({ where: { id: auctionId } });
        if (!auction) throw new BadRequestException('auction not found');
        const now = new Date();
        if (now < auction.startAt || now >= auction.endAt) throw new BadRequestException('auction not active');
        if (auction.currentHighestBid && amount <= auction.currentHighestBid) throw new BadRequestException('bid too low');

        // ensure bidder exists
        let bidder = await tx.user.findUnique({ where: { id: bidderId } });
        if (!bidder) {
          bidder = await tx.user.create({ data: { id: bidderId, name: `guest-${bidderId}`, email: `${bidderId}@example.invalid`, password: 'changeme' } });
        }

        const bid = await tx.bid.create({ data: { auctionId, bidderId: bidder.id, amount } });
        await tx.auction.update({ where: { id: auctionId }, data: { currentHighestBid: amount } });
        // produce BidPlaced event
        kafkaService.send('auction.events', { type: 'BidPlaced', data: { bidId: bid.id, auctionId, bidderId: bidder.id, amount, createdAt: bid.createdAt } });
        return { bidId: bid.id, status: 'placed' };
      });
    } finally {
      await this.redis.del(lockKey);
    }
  }

  async createAuction(data: any) {
    const productId = data.productId;
    const startAt = data.startAt ? new Date(data.startAt) : new Date();
    const endAt = data.endAt ? new Date(data.endAt) : new Date(Date.now() + 60 * 1000);
    const startPrice = Number(data.startingPrice || data.startPrice || 0);
    const auction = await this.prisma.auction.create({ data: { productId, startPrice, startAt, endAt } });
    return auction;
  }

  async getAuction(id: string) {
    return this.prisma.auction.findUnique({ where: { id } });
  }

  async getBids(auctionId: string) {
    return this.prisma.bid.findMany({ where: { auctionId }, orderBy: { createdAt: 'desc' } });
  }
}
