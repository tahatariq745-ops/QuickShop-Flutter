import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quickshop/app.dart';
import 'package:quickshop/models/shop_store.dart';
import 'package:quickshop/screens/add_product_screen.dart';
import 'package:quickshop/screens/gesture_animation_screen.dart';

void main() {
  testWidgets('splash opens first and navigates to the Home Screen', (tester) async {
    await tester.pumpWidget(const QuickShopApp());
    expect(find.text('Welcome! Your next favourite find awaits.'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Featured products'), findsOneWidget);
    expect(find.text('Wireless Headphones'), findsOneWidget);
  });

  testWidgets('Add Product validates inputs and clears them after success', (tester) async {
    final store = ShopStore();
    addTearDown(store.dispose);
    await tester.pumpWidget(MaterialApp(home: AddProductScreen(store: store)));
    await tester.ensureVisible(find.byKey(const Key('submit-product')));
    await tester.tap(find.byKey(const Key('submit-product')));
    await tester.pumpAndSettle();
    expect(find.text('This field is required'), findsNWidgets(2));
    expect(find.text('Price is required'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('product-name')), 'Phone Stand');
    await tester.enterText(find.byKey(const Key('product-price')), '750');
    await tester.enterText(find.byKey(const Key('product-description')),
        'A compact stand for your phone.');
    await tester.ensureVisible(find.byKey(const Key('submit-product')));
    await tester.tap(find.byKey(const Key('submit-product')));
    await tester.pumpAndSettle();
    expect(store.products.first.name, 'Phone Stand');
    expect(find.text('Added this visit: 1'), findsOneWidget);
    expect(find.text('Phone Stand'), findsNothing); // input was cleared
  });

  testWidgets('counter increments and decrements using setState', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: GestureAnimationScreen()));
    await tester.ensureVisible(find.byKey(const Key('increment-counter')));
    await tester.tap(find.byKey(const Key('increment-counter')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.byKey(const Key('decrement-counter')));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });
}
