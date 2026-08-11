import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/product.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Storefront')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Search products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for products, categories, brands...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Top Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                Chip(label: Text('Electronics')),
                Chip(label: Text('Fashion')),
                Chip(label: Text('Home')),
                Chip(label: Text('Beauty')),
                Chip(label: Text('Auction')),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Featured Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Column(
              children: sampleProducts.map((product) => _ProductTile(product: product)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  final Product product;

  const _ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.network(product.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
        title: Text(product.title),
        subtitle: Text('${product.category} • ${product.vendor}\n₹${product.price.toStringAsFixed(0)} • ${product.rating} ★'),
        isThreeLine: true,
        trailing: Icon(product.isAuction ? Icons.gavel : Icons.shopping_cart),
      ),
    );
  }
}
