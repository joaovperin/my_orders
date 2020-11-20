import 'dart:convert';

import 'package:my_orders/utils/abstract_model.dart';

class Product extends AbstractModel<Product> {
  final int id;
  final String description;
  final String reference;
  final double value;

  Product({
    this.id,
    this.description,
    this.reference,
    this.value,
  });

  Product copyWith({
    int id,
    String description,
    String reference,
    double value,
  }) {
    return Product(
      id: id ?? this.id,
      description: description ?? this.description,
      reference: reference ?? this.reference,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'reference': reference,
      'value': value,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Product(
      id: map['id'],
      description: map['description'],
      reference: map['reference'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, description: $description, reference: $reference, value: $value)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product && o.id == id && o.description == description && o.reference == reference && o.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^ description.hashCode ^ reference.hashCode ^ value.hashCode;
  }
}
