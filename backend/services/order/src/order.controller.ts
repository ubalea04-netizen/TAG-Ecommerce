import { Controller, Post, Body } from '@nestjs/common';
import { OrderService } from './order.service';

@Controller('orders')
export class OrderController {
  constructor(private svc: OrderService) {}

  @Post('checkout')
  async checkout(@Body() body: any) {
    const { cartItems, shippingAddressId } = body;
    return this.svc.checkout(cartItems, shippingAddressId);
  }
}
