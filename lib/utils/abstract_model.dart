import 'package:flutter/foundation.dart';

import 'db-utils.dart';

///
/// A class to be extended by all models
///
abstract class AbstractModel<T> {
  int id;

  Map<String, dynamic> toMap();
  T copyWith({int id});
}

///
/// Abstract model provider, also known as DAO
///
abstract class AbstractModelProvider<T extends AbstractModel> with ChangeNotifier {
  final tableName;

  // Create callbacks
  void beforeSave(T register) {}
  void afterSave(T register) {}
  // Read callbacks
  void beforeRead(int id) {}
  void afterRead(T register) {}
  // Delete callbacks
  void beforeDelete(T register) {}
  void afterDelete(T register) {}

  AbstractModelProvider(this.tableName);

  T fromMap(Map<String, dynamic> map);

  Future<T> save(T register) async {
    beforeSave(register);
    final registerId = await DbUtils.insert(tableName, register.toMap());
    final newRegister = register.copyWith(id: registerId);
    afterSave(newRegister);
    notifyListeners();
    return newRegister;
  }

  Future<T> findById(int id) async {
    beforeRead(id);
    T register; // can be null
    final list = await find('id = ?', [id]);
    if (list.isNotEmpty) {
      register = list[0];
    }
    afterRead(register);
    notifyListeners();
    return register;
  }

  Future<List<T>> find(String filter, List<dynamic> args) async {
    final list = await DbUtils.query(tableName, where: filter, args: args);
    List<T> response = [];
    if (list.isNotEmpty) {
      response.addAll(
        list.map((elm) => fromMap(elm)).toList(),
      );
    }
    notifyListeners();
    return response;
  }

  Future<void> delete(T register) async {
    beforeDelete(register);
    await DbUtils.delete(tableName, register.id);
    afterDelete(register);
    notifyListeners();
  }
}

///
/// Abstraction for a provider with a cached register list, to help creating List or Grid Views
///
abstract class AbstractModelListProvider<T extends AbstractModel> extends AbstractModelProvider<T> {
  final List<T> _list = [];

  AbstractModelListProvider(tableName) : super(tableName);

  Future<void> loadList() async {
    (await DbUtils.query(tableName)).forEach((e) {
      _list.add(fromMap(e));
    });

    notifyListeners();
  }

  List<T> get list {
    return [..._list];
  }

  int get count {
    return _list.length;
  }

  T getByIndex(int index) {
    return _list[index];
  }

  void afterSave(register) {
    _list.add(register);
  }

  void afterDelete(register) {
    _list.remove(register);
  }
}
