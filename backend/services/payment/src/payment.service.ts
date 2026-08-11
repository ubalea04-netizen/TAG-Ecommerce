import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from './prisma.service';
import { stripeAdapter } from './gateway/stripe.adapter';

@Injectable()
export class PaymentService {
  constructor(private prisma: PrismaService) {}

  async createIntent(amount: number, currency = 'INR') {
    if (amount <= 0) throw new BadRequestException('amount must be > 0');
    // create DB record
    const payment = await this.prisma.payment.create({ data: { amount, currency, status: 'PENDING' } });
    // call gateway (simulated)
    const gw = await stripeAdapter.createPaymentIntent(amount, currency);
    await this.prisma.payment.update({ where: { id: payment.id }, data: { externalId: gw.externalId, status: 'AUTHORIZED' } });
    const updated = await this.prisma.payment.findUnique({ where: { id: payment.id } });
    return updated;
  }

  async capture(id: string, amount?: number) {
    const p = await this.prisma.payment.findUnique({ where: { id } });
    if (!p) throw new NotFoundException('payment not found');
    if (p.status !== 'PENDING' && p.status !== 'AUTHORIZED') throw new BadRequestException('payment not capturable');
    // call gateway capture (simulated)
    if (!p.externalId) throw new BadRequestException('no external id for payment');
    const gw = await stripeAdapter.capturePayment(p.externalId, amount);
    const updated = await this.prisma.payment.update({ where: { id }, data: { status: 'CAPTURED' } });
    return updated;
  }
}
