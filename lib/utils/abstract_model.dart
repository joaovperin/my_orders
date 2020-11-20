import 'package:flutter/foundation.dart';

import 'db-utils.dart';

abstract class AbstractModel<T> {
  int id;

  Map<String, dynamic> toMap();
  T copyWith({int id});
}

abstract class AbstractModelProvider<T extends AbstractModel> with ChangeNotifier {
  final List<T> _items = [];

  final tableName;

  AbstractModelProvider(this.tableName);

  T fromMap(Map<String, dynamic> map);

  Future<void> loadRegisters() async {
    (await DbUtils.query(tableName)).forEach((e) {
      _items.add(fromMap(e));
    });

    notifyListeners();
  }

  List<T> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  T itemByIndex(int index) {
    return _items[index];
  }

  Future<T> addRegister(T register) async {
    final registerId = await DbUtils.insert(tableName, register.toMap());
    final newRegister = register.copyWith(id: registerId);
    _items.add(newRegister);
    notifyListeners();
    return newRegister;
  }

  Future<void> removeRegister(T register) async {
    _items.remove(register);
    await DbUtils.delete(tableName, register.id);
    notifyListeners();
  }
}
