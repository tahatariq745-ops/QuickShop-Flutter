import 'dart:async';
import 'package:flutter/material.dart';

import '../core/app_routes.dart';
import '../core/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppTheme.heroGradient),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 118,
                width: 118,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white30),
                ),
                child: const Icon(Icons.shopping_bag_rounded,
                    color: Colors.white, size: 68),
              ),
              const SizedBox(height: 24),
              const Text('QuickShop', style: TextStyle(
                color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800)),
              const SizedBox(height: 9),
              const Text('Welcome! Your next favourite find awaits.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 15)),
              const SizedBox(height: 36),
              const SizedBox(
                height: 28,
                width: 28,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
