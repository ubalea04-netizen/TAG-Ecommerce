import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/product.dart';

class SellerPanelScreen extends StatefulWidget {
  const SellerPanelScreen({super.key});

  @override
  State<SellerPanelScreen> createState() => _SellerPanelScreenState();
}

class _SellerPanelScreenState extends State<SellerPanelScreen> {
  late List<Product> products;

  @override
  void initState() {
    super.initState();
    products = List<Product>.from(sampleProducts);
  }

  void _addSampleProduct() {
    setState(() {
      products.add(
        Product(
          id: 'p${products.length + 1}',
          title: 'New Seller Product ${products.length + 1}',
          category: 'Misc',
          vendor: 'SellerCo',
          price: 1999.0,
          rating: 4.2,
          isAuction: false,
          imageUrl: 'https://via.placeholder.com/150',
          inventoryCount: 50,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalInventory = products.fold<int>(0, (sum, item) => sum + item.inventoryCount);
    final auctionCount = products.where((product) => product.isAuction).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Seller Panel')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Seller Dashboard', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Manage products, inventory, auctions, orders, and earnings from one place.'),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoTile(label: 'Products', value: products.length.toString()),
                _InfoTile(label: 'Inventory', value: totalInventory.toString()),
                _InfoTile(label: 'Auctions', value: auctionCount.toString()),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  const Text('Product Upload & Management', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _addSampleProduct,
                    icon: const Icon(Icons.add),
                    label: const Text('Add new product'),
                  ),
                  const SizedBox(height: 16),
                  ...products.map((product) => _SellerProductTile(product: product)).toList(),
                  const SizedBox(height: 24),
                  const Text('Auction Product Listing', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text('Use this panel to list auction products, manage bids, and track live items.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.only(right: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class _SellerProductTile extends StatelessWidget {
  final Product product;

  const _SellerProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.network(product.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
        title: Text(product.title),
        subtitle: Text('Inventory: ${product.inventoryCount} • ₹${product.price.toStringAsFixed(0)}'),
        trailing: product.isAuction ? const Icon(Icons.gavel) : const Icon(Icons.store),
      ),
    );
  }
}
