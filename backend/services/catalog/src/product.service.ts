import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from './prisma.service';
import { kafkaService } from './kafka.service';

@Injectable()
export class ProductService {
  constructor(private prisma: PrismaService) {}

  async create(data: any) {
    // Ensure required fields for Prisma Product model
    if (!data.sellerId) {
      // create a placeholder user + seller for dev/testing
      const user = await this.prisma.user.create({ data: { email: `dev-seller-${Date.now()}@example.com`, password: 'devpass', name: 'Dev Seller' } });
      const seller = await this.prisma.seller.create({ data: { userId: user.id, storeName: 'Dev Store' } });
      data.sellerId = seller.id;
    }

    const payload = {
      title: data.title || data.name || 'Untitled',
      sku: data.sku || `sku-${Date.now()}`,
      price: Number(data.price || 100),
      inventory: Number(data.inventory || 0),
      sellerId: data.sellerId,
      auction: !!data.auction,
    };

    const prod = await this.prisma.product.create({ data: payload });
    // emit ProductCreated event
    kafkaService.send('product.events', { type: 'ProductCreated', data: prod });
    return prod;
  }

  async findOne(id: string) {
    return this.prisma.product.findUnique({ where: { id } });
  }

  async findMany() {
    return this.prisma.product.findMany({ orderBy: { createdAt: 'desc' } });
  }

  async reserveInventory(id: string, quantity: number) {
    if (quantity <= 0) throw new BadRequestException('quantity must be > 0');
    return this.prisma.$transaction(async (tx) => {
      const p = await tx.product.findUnique({ where: { id } });
      if (!p) throw new BadRequestException('product not found');
      if (p.inventory < quantity) throw new BadRequestException('insufficient inventory');
      await tx.product.update({ where: { id }, data: { inventory: p.inventory - quantity } });
      return { reserved: true, reservedQty: quantity };
    });
  }
}
