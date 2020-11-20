import 'dart:convert';

import 'package:my_orders/utils/abstract_model.dart';

class Customer extends AbstractModel<Customer> {
  final int id;
  final String name;
  final String address;

  Customer(
    this.id,
    this.name,
    this.address,
  );

  Customer copyWith({
    int id,
    String name,
    String address,
  }) {
    return Customer(
      id ?? this.id,
      name ?? this.name,
      address ?? this.address,
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
      map['id'],
      map['name'],
      map['address'],
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
