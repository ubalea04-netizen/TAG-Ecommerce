import 'reflect-metadata';
import { Controller, Post, Body, Get, Param } from '@nestjs/common';
import { ProductService } from './product.service';

@Controller('products')
export class ProductController {
  constructor(private svc: ProductService) {}

  @Post()
  async create(@Body() body: any) {
    return this.svc.create(body);
  }

  @Get(':id')
  async get(@Param('id') id: string) {
    return this.svc.findOne(id);
  }

  @Get()
  async list() {
    return this.svc.findMany();
  }

  @Post(':id/inventory/reserve')
  async reserve(@Param('id') id: string, @Body() body: any) {
    const qty = Number(body.quantity || 0);
    return this.svc.reserveInventory(id, qty);
  }
}
