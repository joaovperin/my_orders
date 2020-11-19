import 'package:flutter/material.dart';
import 'package:my_orders/modules/customer/customer_model.dart';
import 'package:my_orders/utils/db-utils.dart';
import 'package:my_orders/utils/string_utils.dart';

class CustomersProvider with ChangeNotifier {
  static const kTableName = 'customer';
  final List<Customer> _items = [];

  Future<void> loadRegisters() async {
    (await DbUtils.query(kTableName)).forEach((e) {
      _items.add(Customer.fromMap(e));
    });

    notifyListeners();
  }

  List<Customer> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Customer itemByIndex(int index) {
    return _items[index];
  }

  Future<Customer> addRegister(Customer register) async {
    final registerId = await DbUtils.insert(kTableName, register.toMap());
    final newRegister = register.copyWith(id: registerId);
    _items.add(newRegister);
    notifyListeners();
    return newRegister;
  }

  Future<void> removeCustomer(Customer register) async {
    _items.remove(register);
    await DbUtils.delete(kTableName, register.id);
    notifyListeners();
  }

  Future<Customer> addRandomRegister() async {
    final idx = itemsCount;
    final register = Customer.fromMap({
      'name': 'Customer ${idx + 1}',
      'address': randomString(idx),
    });
    return addRegister(register);
  }
}
