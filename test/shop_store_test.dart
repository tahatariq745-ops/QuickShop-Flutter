import 'package:flutter_test/flutter_test.dart';
import 'package:quickshop/models/shop_store.dart';

void main() {
  test('adding a product updates the in-memory Dart List', () {
    final store = ShopStore();
    final before = store.products.length;
    store.addProduct(
      name: 'Test Speaker',
      price: 1500,
      description: 'A test item for the assignment.',
    );
    expect(store.products.length, before + 1);
    expect(store.products.first.name, 'Test Speaker');
    expect(store.products.first.price, 1500);
    store.dispose();
  });

  test('favourite and Add to Cart update their state', () {
    final store = ShopStore();
    final product = store.products.first;
    expect(product.isFavorite, isFalse);
    store.toggleFavorite(product);
    expect(product.isFavorite, isTrue);
    store.addToCart(product);
    expect(store.cartCount, 1);
    store.dispose();
  });
}
