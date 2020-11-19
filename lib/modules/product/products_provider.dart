import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_orders/modules/product/product_model.dart';
import 'package:my_orders/utils/db-utils.dart';
import 'package:my_orders/utils/string_utils.dart';

class ProductsProvider with ChangeNotifier {
  static const kTableName = 'product';
  final List<Product> _items = [];

  Future<void> loadRegisters() async {
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

  Future<Product> addRegister(Product register) async {
    final registerId = await DbUtils.insert(kTableName, register.toMap());
    final newRegister = register.copyWith(id: registerId);
    _items.add(newRegister);
    notifyListeners();
    return newRegister;
  }

  Future<void> removeProduct(Product register) async {
    _items.remove(register);
    await DbUtils.delete(kTableName, register.id);
    notifyListeners();
  }

  Future<Product> addRandomRegister() async {
    final idx = itemsCount;
    final register = Product.fromMap({
      'description': 'Product ${idx + 1}',
      'reference': randomString(idx),
      'value': 50 + 300 * Random().nextDouble(),
    });
    return addRegister(register);
  }
}
