import 'package:my_orders/modules/customer/customer_model.dart';
import 'package:my_orders/utils/abstract_model.dart';

import 'order_model.dart';

class OrdersPageProvider extends AbstractModelListProvider<Order> {
  OrdersPageProvider() : super(OrderDao());

  /// Customers cache
  Map<int, Customer> customers = {};

  Future<Customer> customer(Order order) async {
    if (customers[order.customerId] != null) {
      return customers[order.customerId];
    }
    // Query and update cache
    Customer customer = await const CustomerDao().findById(order.customerId);
    customers[order.customerId] = customer;
    return customer;
  }

  String fmtEntryDate(Order order) {
    return '20/11/2020';
  }

  String fmtTotalValue(Order order) {
    return r'R$ 50.23';
  }

  Order fromMap(Map<String, dynamic> map) {
    return Order.fromMap(map);
  }
}
