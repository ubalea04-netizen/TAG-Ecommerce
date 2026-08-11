import { Controller, Post, Body, Param } from '@nestjs/common';
import { PaymentService } from './payment.service';

@Controller('payments')
export class PaymentController {
  constructor(private svc: PaymentService) {}

  @Post('intents')
  async createIntent(@Body() body: any) {
    const amount = Number(body.amount);
    const currency = body.currency || 'INR';
    return this.svc.createIntent(amount, currency);
  }

  @Post(':id/capture')
  async capture(@Param('id') id: string) {
    return this.svc.capture(id);
  }
}
