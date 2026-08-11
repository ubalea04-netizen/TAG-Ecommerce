import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Injectable()
export class ProductService {
  constructor(private prisma: PrismaService) {}

  async create(data: any) {
    return this.prisma.product.create({ data });
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
