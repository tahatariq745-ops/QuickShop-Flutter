import 'package:flutter/material.dart';

import '../core/app_drawer.dart';
import '../core/app_routes.dart';
import '../core/app_theme.dart';
import '../models/shop_store.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  final ShopStore store;
  const HomeScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QuickShop')),
      drawer: const AppDrawer(currentRoute: AppRoutes.home),
      body: AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: AppTheme.heroGradient,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('A little shopping joy.',
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800,
                        color: Colors.white)),
                    const SizedBox(height: 7),
                    const Text('Find something useful for every day.',
                      style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _SummaryPill(
                          icon: Icons.inventory_2_outlined,
                          label: '${store.products.length} products'),
                        _SummaryPill(
                          icon: Icons.shopping_cart_outlined,
                          label: '${store.cartCount} in cart'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 23),
              Row(
                children: [
                  const Expanded(child: Text('Featured products', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w800,
                    color: AppTheme.navy))),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.products),
                    child: const Text('View all'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              for (final product in store.products.take(4)) ...[
                ProductCard(product: product, store: store),
                const SizedBox(height: 11),
              ],
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.addProduct),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add a new product'),
              ),
              const SizedBox(height: 12),
              const Text('Tip: tap a product for details, double-tap for '
                'favourite, or long-press for a message.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppTheme.muted)),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SummaryPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white,
            fontWeight: FontWeight.w600, fontSize: 12)),
        ],
      ),
    );
  }
}
