import 'package:flutter/material.dart';

/// Small, self-contained model. Each product has its own title, price, and text.
class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final IconData icon;
  final Color color;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.icon,
    required this.color,
    this.isFavorite = false,
  });

  String get formattedPrice => 'Rs ${price.toStringAsFixed(2)}';
}
