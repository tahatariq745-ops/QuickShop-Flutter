import 'package:flutter/material.dart';

import '../core/app_drawer.dart';
import '../core/app_routes.dart';
import '../core/app_theme.dart';
import '../models/shop_store.dart';

class AddProductScreen extends StatefulWidget {
  final ShopStore store;
  const AddProductScreen({super.key, required this.store});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _addedThisVisit = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) return 'Price is required';
    final price = double.tryParse(value.trim());
    if (price == null || !price.isFinite || price <= 0) {
      return 'Enter a valid price greater than 0';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.store.addProduct(
      name: _nameController.text.trim(),
      price: double.parse(_priceController.text.trim()),
      description: _descriptionController.text.trim(),
    );

    // Submission requirement: all three inputs are cleared after success.
    _nameController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _formKey.currentState!.reset();
    FocusScope.of(context).unfocus();
    setState(() => _addedThisVisit++);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(
        content: Text('Product added! It is now available on Home and Products.'),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      drawer: const AppDrawer(currentRoute: AppRoutes.addProduct),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.mint,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.add_shopping_cart_rounded,
                      color: AppTheme.teal, size: 32),
                    SizedBox(width: 13),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add something new', style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w800,
                          color: AppTheme.navy)),
                        SizedBox(height: 3),
                        Text('Products stay in memory while the app is running.',
                          style: TextStyle(color: AppTheme.muted, fontSize: 12)),
                      ],
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const Text('Product Name', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 7),
              TextFormField(
                key: const Key('product-name'),
                controller: _nameController,
                validator: _required,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'e.g. Bluetooth Speaker',
                  prefixIcon: Icon(Icons.label_outline_rounded),
                ),
              ),
              const SizedBox(height: 18),
              const Text('Product Price (Rs)',
                style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 7),
              TextFormField(
                key: const Key('product-price'),
                controller: _priceController,
                validator: _validatePrice,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'e.g. 1999.00',
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
              ),
              const SizedBox(height: 18),
              const Text('Product Description',
                style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 7),
              TextFormField(
                key: const Key('product-description'),
                controller: _descriptionController,
                validator: _required,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Write a short description of the product...',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  key: const Key('submit-product'),
                  onPressed: _submit,
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Add Product'),
                ),
              ),
              if (_addedThisVisit > 0) ...[
                const SizedBox(height: 15),
                Text('Added this visit: $_addedThisVisit',
                  style: const TextStyle(color: AppTheme.teal,
                    fontWeight: FontWeight.w700)),
                const SizedBox(height: 7),
                TextButton.icon(
                  onPressed: () => Navigator.of(context)
                    .popUntil(ModalRoute.withName(AppRoutes.home)),
                  icon: const Icon(Icons.home_outlined),
                  label: const Text('View on Home'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
