import 'package:my_orders/utils/abstract_model.dart';

import 'order_item_model.dart';

class OrderItemsProvider extends AbstractModelListProvider<OrderItem> {
  static const kTableName = 'order_item';

  OrderItemsProvider() : super(kTableName);

  @override
  OrderItem fromMap(Map<String, dynamic> map) {
    return OrderItem.fromMap(map);
  }
}
