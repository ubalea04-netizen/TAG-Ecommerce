import 'reflect-metadata';
import { PaymentService } from '../src/payment.service';

// Mock PrismaService
const mockPrisma: any = {
  payment: {
    create: jest.fn().mockImplementation(({ data }) => Promise.resolve({ id: 'p1', ...data })),
    findUnique: jest.fn().mockImplementation(({ where }) => Promise.resolve({ id: where.id, amount: 100, status: 'PENDING' })),
    update: jest.fn().mockImplementation(({ where, data }) => Promise.resolve({ id: where.id, ...data })),
  },
};

describe('PaymentService', () => {
  let svc: PaymentService;
  beforeAll(() => {
    svc = new PaymentService(mockPrisma as any);
  });

  it('creates an intent', async () => {
    const res = await svc.createIntent(1000, 'INR');
    expect(res).toBeDefined();
    expect((res as any).id).toBeDefined();
  });

  it('captures a payment', async () => {
    // mock findUnique to return a payment with externalId
    mockPrisma.payment.findUnique.mockResolvedValueOnce({ id: 'p1', amount: 1000, status: 'AUTHORIZED', externalId: 'pi_123' });
    const res = await svc.capture('p1');
    expect(res.status).toBe('CAPTURED');
  });
});
