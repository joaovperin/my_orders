import 'package:my_orders/utils/abstract_model.dart';

import 'order_model.dart';

class OrdersProvider extends AbstractModelListProvider<Order> {
  static const kTableName = 'order';

  OrdersProvider(tableName) : super(tableName);

  @override
  Order fromMap(Map<String, dynamic> map) {
    return Order.fromMap(map);
  }
}
