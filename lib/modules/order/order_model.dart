import 'dart:convert';

import 'package:my_orders/utils/abstract_model.dart';

class Order extends AbstractModel<Order> {
  final int id;
  final int customerId;
  final DateTime entryDate;
  final double totalValue;

  Order({
    this.id,
    this.customerId,
    this.entryDate,
    this.totalValue,
  });

  Order copyWith({
    int id,
    int customerId,
    DateTime entryDate,
    double totalValue,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      entryDate: entryDate ?? this.entryDate,
      totalValue: totalValue ?? this.totalValue,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'entryDate': entryDate?.millisecondsSinceEpoch,
      'totalValue': totalValue,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(
      id: map['id'],
      customerId: map['customerId'],
      entryDate: DateTime.fromMillisecondsSinceEpoch(map['entryDate']),
      totalValue: map['totalValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, customerId: $customerId, entryDate: $entryDate, totalValue: $totalValue)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Order && o.id == id && o.customerId == customerId && o.entryDate == entryDate && o.totalValue == totalValue;
  }

  @override
  int get hashCode {
    return id.hashCode ^ customerId.hashCode ^ entryDate.hashCode ^ totalValue.hashCode;
  }
}
