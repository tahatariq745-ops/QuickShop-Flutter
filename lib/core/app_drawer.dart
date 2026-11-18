import 'package:flutter/material.dart';
import 'app_routes.dart';
import 'app_theme.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  const AppDrawer({super.key, required this.currentRoute});

  static const _items = <({String route, String title, IconData icon})>[
    (route: AppRoutes.home, title: 'Home', icon: Icons.home_outlined),
    (route: AppRoutes.products, title: 'Products', icon: Icons.storefront_outlined),
    (route: AppRoutes.addProduct, title: 'Add Product', icon: Icons.add_box_outlined),
    (route: AppRoutes.gestures, title: 'Gestures & Animation', icon: Icons.touch_app_outlined),
    (route: AppRoutes.web, title: 'WebView', icon: Icons.language_rounded),
  ];

  void _navigate(BuildContext context, String destination) {
    final navigator = Navigator.of(context);
    navigator.pop(); // Close the drawer.
    if (destination == currentRoute) return;
    if (destination == AppRoutes.home) {
      navigator.popUntil(ModalRoute.withName(AppRoutes.home));
    } else if (currentRoute == AppRoutes.home) {
      navigator.pushNamed(destination);
    } else {
      navigator.pushReplacementNamed(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = _items.indexWhere((item) => item.route == currentRoute);
    return NavigationDrawer(
      selectedIndex: selected < 0 ? 0 : selected,
      onDestinationSelected: (index) =>
          _navigate(context, _items[index].route),
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 18),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppTheme.heroGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 42),
              SizedBox(height: 12),
              Text('QuickShop', style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w800, fontSize: 24,
              )),
              SizedBox(height: 4),
              Text('Explore, tap and shop', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        for (final item in _items)
          NavigationDrawerDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.icon, color: AppTheme.teal),
            label: Text(item.title),
          ),
        const Padding(
          padding: EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Text('Mobile Computing - Assignment 1',
            style: TextStyle(fontSize: 12, color: AppTheme.muted)),
        ),
      ],
    );
  }
}
