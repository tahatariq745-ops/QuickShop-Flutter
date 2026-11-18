import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../models/product.dart';
import '../models/shop_store.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final ShopStore store;

  const ProductDetailScreen({super.key, required this.product, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: product.color,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Icon(product.icon, size: 105, color: AppTheme.navy),
              ),
              const SizedBox(height: 25),
              Text(product.name, style: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.w800, color: AppTheme.navy)),
              const SizedBox(height: 8),
              Text(product.formattedPrice, style: const TextStyle(
                fontSize: 22, color: AppTheme.teal, fontWeight: FontWeight.w800)),
              const SizedBox(height: 24),
              const Text('Description', style: TextStyle(
                fontSize: 17, color: AppTheme.navy, fontWeight: FontWeight.w800)),
              const SizedBox(height: 9),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(product.description,
                    style: const TextStyle(fontSize: 15, color: AppTheme.muted,
                      height: 1.6)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    store.addToCart(product);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text('${product.name} added to cart! '
                            'Items in cart: ${store.cartCount}'),
                      ));
                  },
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                  label: const Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
