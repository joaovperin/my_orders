import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_orders/modules/product/product_model.dart';
import 'package:my_orders/utils/db-utils.dart';

class ProductsProvider with ChangeNotifier {
  static const kTableName = 'product';
  final List<Product> _items = [];

  Future<void> loadProducts() async {
    (await DbUtils.query(kTableName)).forEach((e) {
      _items.add(Product.fromMap(e));
    });

    notifyListeners();
  }

  List<Product> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Product itemByIndex(int index) {
    return _items[index];
  }

  Future<Product> addProduct(Product product) async {
    final productId = await DbUtils.insert(kTableName, product.toMap());
    final newProduct = product.copyWith(id: productId);
    _items.add(newProduct);
    notifyListeners();
    return newProduct;
  }

  Future<void> removeProduct(Product product) async {
    _items.remove(product);
    await DbUtils.delete(kTableName, product.id);
    notifyListeners();
  }

  static String _generateRandomAddress(int id) {
    final rng = Random(128 * (32 + id * 250));
    final size = 5 + rng.nextInt(13);
    String text = String.fromCharCode(65 + rng.nextInt(25));
    for (var i = 1; i < size; i++) {
      text += String.fromCharCode(97 + rng.nextInt(25));
    }
    return text;
  }

  Future<Product> addRandomProduct() async {
    final idx = itemsCount;
    final product = Product.fromMap({
      'description': 'Product ${idx + 1}',
      'reference': _generateRandomAddress(idx),
      'value': 50 + 300 * Random().nextDouble(),
    });
    return addProduct(product);
  }
}
