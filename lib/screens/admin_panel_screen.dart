import 'package:flutter/material.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final List<String> pendingSellers = ['FreshVendor', 'EcoStore', 'AuctionPro'];
  final List<String> pendingProducts = ['Smart Lamp', 'Kitchen Mixer', 'Designer Jacket'];
  double commissionRate = 5.0;
  bool percentPlusFixed = true;

  void _approveSeller(String seller) {
    setState(() {
      pendingSellers.remove(seller);
    });
  }

  void _approveProduct(String product) {
    setState(() {
      pendingProducts.remove(product);
    });
  }

  void _toggleCommissionMode(bool? value) {
    if (value == null) return;
    setState(() {
      percentPlusFixed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Admin Controls', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Approve sellers, approve products, configure commission, and monitor payments.'),
            const SizedBox(height: 24),
            const Text('Pending Seller Approvals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...pendingSellers.map((seller) => Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text(seller),
                subtitle: const Text('Verification pending'),
                trailing: ElevatedButton(
                  onPressed: () => _approveSeller(seller),
                  child: const Text('Approve'),
                ),
              ),
            )),
            const SizedBox(height: 24),
            const Text('Pending Product Approvals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...pendingProducts.map((product) => Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text(product),
                subtitle: const Text('Awaiting admin review'),
                trailing: ElevatedButton(
                  onPressed: () => _approveProduct(product),
                  child: const Text('Approve'),
                ),
              ),
            )),
            const SizedBox(height: 24),
            const Text('Commission Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Slider(
              value: commissionRate,
              min: 0,
              max: 20,
              divisions: 20,
              label: '${commissionRate.toStringAsFixed(0)}%',
              onChanged: (value) => setState(() => commissionRate = value),
            ),
            Row(
              children: [
                Radio<bool>(value: true, groupValue: percentPlusFixed, onChanged: _toggleCommissionMode),
                const Text('Percent + Fixed'),
              ],
            ),
            Row(
              children: [
                Radio<bool>(value: false, groupValue: percentPlusFixed, onChanged: _toggleCommissionMode),
                const Text('Percent only'),
              ],
            ),
            const SizedBox(height: 8),
            Card(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Current commission: ${commissionRate.toStringAsFixed(0)}% ${percentPlusFixed ? '+ fixed fee' : ''}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
