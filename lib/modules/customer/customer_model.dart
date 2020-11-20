import 'dart:convert';

import 'package:my_orders/utils/abstract_model.dart';

/// Data access object
class CustomerDao extends AbstractModelDao<Customer> {
  static const kTableName = 'customer';
  const CustomerDao() : super(kTableName);

  @override
  Customer fromMap(Map<String, dynamic> map) {
    return Customer.fromMap(map);
  }
}

/// Model object
class Customer extends AbstractModel<Customer> {
  final int id;
  final String name;
  final String address;

  Customer({
    this.id,
    this.name,
    this.address,
  });

  Customer copyWith({
    int id,
    String name,
    String address,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Customer(
      id: map['id'],
      name: map['name'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source));

  @override
  String toString() => 'Customer(id: $id, name: $name, address: $address)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Customer && o.id == id && o.name == name && o.address == address;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ address.hashCode;
}
