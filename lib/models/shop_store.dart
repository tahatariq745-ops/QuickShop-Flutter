import 'package:flutter/material.dart';
import 'product.dart';

/// Flutter's built-in ChangeNotifier lets existing screens refresh when
/// this *in-memory Dart List* changes. No external state-management package.
class ShopStore extends ChangeNotifier {
  final List<Product> products = [
    Product(
      id: 'p1',
      name: 'Wireless Headphones',
      price: 3499,
      description:
          'Comfortable over-ear wireless headphones with clear sound, soft '
          'ear cushions and a rechargeable battery for everyday listening.',
      icon: Icons.headphones_rounded,
      color: const Color(0xFFDEEEFF),
    ),
    Product(
      id: 'p2',
      name: 'Classic Backpack',
      price: 2499,
      description:
          'A lightweight backpack with a padded laptop pocket and space '
          'for books, chargers and daily essentials.',
      icon: Icons.backpack_rounded,
      color: const Color(0xFFFFEAD9),
    ),
    Product(
      id: 'p3',
      name: 'Smart Watch',
      price: 5999,
      description:
          'A simple smart watch for checking the time, daily activity '
          'and phone notifications on the go.',
      icon: Icons.watch_rounded,
      color: const Color(0xFFEAE7FF),
    ),
    Product(
      id: 'p4',
      name: 'Reusable Water Bottle',
      price: 899,
      description:
          'A reusable daily water bottle with a leak-resistant lid and '
          'a convenient size for school, work and travel.',
      icon: Icons.water_drop_rounded,
      color: const Color(0xFFDCF6EB),
    ),
    Product(
      id: 'p5',
      name: 'Desk Lamp',
      price: 1899,
      description:
          'A practical study lamp with an adjustable head and soft light '
          'for reading or working at a desk.',
      icon: Icons.lightbulb_rounded,
      color: const Color(0xFFFFF1D6),
    ),
  ];

  int _cartCount = 0;
  int get cartCount => _cartCount;

  void addProduct({
    required String name,
    required double price,
    required String description,
  }) {
    products.insert(
      0,
      Product(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        price: price,
        description: description,
        icon: Icons.shopping_bag_rounded,
        color: const Color(0xFFDEF5EF),
      ),
    );
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }

  void addToCart(Product product) {
    _cartCount++;
    notifyListeners();
  }
}
