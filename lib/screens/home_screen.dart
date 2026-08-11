import 'package:flutter/material.dart';

import '../app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TAG eCommerce Marketplace'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Platform Overview',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Multi-vendor eCommerce marketplace with normal selling, auction bidding, seller panel, admin panel, and customer storefront.',
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _FeatureCard(
                    label: 'Customer Store',
                    icon: Icons.shopping_bag,
                    onTap: () => Navigator.pushNamed(context, AppRouter.customerHome),
                  ),
                  _FeatureCard(
                    label: 'Seller Panel',
                    icon: Icons.storefront,
                    onTap: () => Navigator.pushNamed(context, AppRouter.sellerPanel),
                  ),
                  _FeatureCard(
                    label: 'Auction Zone',
                    icon: Icons.gavel,
                    onTap: () => Navigator.pushNamed(context, AppRouter.auction),
                  ),
                  _FeatureCard(
                    label: 'Admin Dashboard',
                    icon: Icons.admin_panel_settings,
                    onTap: () => Navigator.pushNamed(context, AppRouter.adminPanel),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 42, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 16),
              Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
