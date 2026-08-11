import 'reflect-metadata';
import { Controller, Post, Body, Param, Get } from '@nestjs/common';
import { AuctionService } from './auction.service';

@Controller('auctions')
export class AuctionController {
  constructor(private svc: AuctionService) {}

  @Post()
  async create(@Body() body: any) {
    return this.svc.createAuction(body);
  }

  @Post(':id/bids')
  async placeBid(@Param('id') id: string, @Body() body: any) {
    const bidderId = body.bidderId;
    const amount = Number(body.amount);
    return this.svc.placeBid(id, bidderId, amount);
  }

  @Get(':id')
  async get(@Param('id') id: string) {
    return this.svc.getAuction(id);
  }

  @Get(':id/bids')
  async bids(@Param('id') id: string) {
    return this.svc.getBids(id);
  }
}
