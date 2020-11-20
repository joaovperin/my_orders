import 'dart:convert';

import 'package:my_orders/utils/abstract_model.dart';

/// Data access object
class OrderItemDao extends AbstractModelDao<OrderItem> {
  static const kTableName = 'order_item';
  const OrderItemDao() : super(kTableName);

  @override
  OrderItem fromMap(Map<String, dynamic> map) {
    return OrderItem.fromMap(map);
  }
}

/// Model object
class OrderItem extends AbstractModel<OrderItem> {
  final int id;
  final int orderId;
  final int sequence;
  final int productId;
  final double quantity;
  final double value;

  OrderItem({
    this.id,
    this.orderId,
    this.sequence,
    this.productId,
    this.quantity,
    this.value,
  });

  OrderItem copyWith({
    int id,
    int orderId,
    int sequence,
    int productId,
    double quantity,
    double value,
  }) {
    return OrderItem(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      sequence: sequence ?? this.sequence,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'sequence': sequence,
      'productId': productId,
      'quantity': quantity,
      'value': value,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return OrderItem(
      id: map['id'],
      orderId: map['orderId'],
      sequence: map['sequence'],
      productId: map['productId'],
      quantity: map['quantity'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) => OrderItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderItem(id: $id, orderId: $orderId, sequence: $sequence, productId: $productId, quantity: $quantity, value: $value)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OrderItem &&
        o.id == id &&
        o.orderId == orderId &&
        o.sequence == sequence &&
        o.productId == productId &&
        o.quantity == quantity &&
        o.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^ orderId.hashCode ^ sequence.hashCode ^ productId.hashCode ^ quantity.hashCode ^ value.hashCode;
  }
}
