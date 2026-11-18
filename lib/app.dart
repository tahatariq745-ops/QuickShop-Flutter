import 'package:flutter/material.dart';

import 'core/app_routes.dart';
import 'core/app_theme.dart';
import 'models/shop_store.dart';
import 'screens/add_product_screen.dart';
import 'screens/gesture_animation_screen.dart';
import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/shop_web_screen.dart';

/// A single in-memory store belongs to the app, so all screens share products.
/// No database, login, API, or persistent storage is used.
class QuickShopApp extends StatefulWidget {
  const QuickShopApp({super.key});

  @override
  State<QuickShopApp> createState() => _QuickShopAppState();
}

class _QuickShopAppState extends State<QuickShopApp> {
  final ShopStore _store = ShopStore();

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickShop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
      routes: {
        AppRoutes.home: (_) => HomeScreen(store: _store),
        AppRoutes.products: (_) => ProductsScreen(store: _store),
        AppRoutes.addProduct: (_) => AddProductScreen(store: _store),
        AppRoutes.gestures: (_) => const GestureAnimationScreen(),
        AppRoutes.web: (_) => const ShopWebScreen(),
      },
    );
  }
}
