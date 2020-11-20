import 'package:my_orders/utils/abstract_model.dart';

import 'order_item_model.dart';

class OrderItemsProvider extends AbstractModelListProvider<OrderItem> {
  OrderItemsProvider() : super(OrderItemDao());
}
