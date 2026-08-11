export class StripeAdapter {
  private apiKey: string;
  constructor() {
    this.apiKey = process.env.STRIPE_API_KEY || '';
  }

  async createPaymentIntent(amount: number, currency = 'INR') {
    // In production, call Stripe's API. Here we simulate and return an external id.
    return { externalId: `pi_${Date.now()}`, status: 'AUTHORIZED' };
  }

  async capturePayment(externalId: string, amount?: number) {
    // Simulate capture
    return { externalId, status: 'CAPTURED' };
  }
}

export const stripeAdapter = new StripeAdapter();
