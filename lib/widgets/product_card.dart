import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../models/product.dart';
import '../models/shop_store.dart';
import '../screens/product_detail_screen.dart';

/// onTap opens details, onDoubleTap toggles favourite, onLongPress responds.
class ProductCard extends StatelessWidget {
  final Product product;
  final ShopStore store;

  const ProductCard({super.key, required this.product, required this.store});

  void _openDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProductDetailScreen(product: product, store: store),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openDetails(context),
      onDoubleTap: () {
        store.toggleFavorite(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(product.isFavorite
              ? '${product.name} added to favourites!'
              : '${product.name} removed from favourites.')),
        );
      },
      onLongPress: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Long press detected: ${product.name}')),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  color: product.color,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Icon(product.icon, size: 35, color: AppTheme.navy),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800,
                        color: AppTheme.navy)),
                    const SizedBox(height: 5),
                    Text(product.description, maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: AppTheme.muted)),
                    const SizedBox(height: 7),
                    Text(product.formattedPrice,
                      style: const TextStyle(fontWeight: FontWeight.w800,
                        fontSize: 15, color: AppTheme.teal)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  Icon(product.isFavorite ? Icons.favorite_rounded : Icons.favorite_border,
                    color: product.isFavorite ? Colors.redAccent : AppTheme.muted,
                    size: 19),
                  const SizedBox(height: 17),
                  const Icon(Icons.chevron_right_rounded,
                    color: AppTheme.muted, size: 22),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
