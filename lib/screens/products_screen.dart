import 'package:flutter/material.dart';

import '../core/app_drawer.dart';
import '../core/app_routes.dart';
import '../core/app_theme.dart';
import '../models/shop_store.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  final ShopStore store;
  const ProductsScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      drawer: const AppDrawer(currentRoute: AppRoutes.products),
      body: AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
            itemCount: store.products.length + 1,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('All products (${store.products.length})',
                      style: const TextStyle(fontWeight: FontWeight.w800,
                        color: AppTheme.navy, fontSize: 20)),
                    const SizedBox(height: 5),
                    const Text('Tap a card to view more details.',
                      style: TextStyle(color: AppTheme.muted)),
                  ],
                );
              }
              return ProductCard(product: store.products[index - 1], store: store);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addProduct),
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
    );
  }
}
