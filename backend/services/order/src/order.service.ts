import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from './prisma.service';
import axios from 'axios';

@Injectable()
export class OrderService {
  constructor(private prisma: PrismaService) {}

  async checkout(cartItems: any[], shippingAddressId: string) {
    if (!cartItems || cartItems.length === 0) throw new BadRequestException('empty cart');
    // compute total (simple)
    const total = cartItems.reduce((s, i) => s + (i.price || 0) * (i.quantity || 1), 0);
    // create payment intent via Payment service
    const paymentResp = await axios.post((process.env.PAYMENT_URL || 'http://localhost:3005') + '/payments/intents', { amount: total, currency: 'INR' });
    const payment = paymentResp.data;
    // create order record
    const order = await this.prisma.order.create({ data: { buyerId: cartItems[0].buyerId || '', totalAmount: total, status: 'PENDING' } });
    return { order, payment };
  }
}
