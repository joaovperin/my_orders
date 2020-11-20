import 'package:my_orders/modules/customer/customer_model.dart';
import 'package:my_orders/utils/abstract_model.dart';
import 'package:my_orders/utils/string_utils.dart';

class CustomersProvider extends AbstractModelProvider<Customer> {
  static const kTableName = 'customer';

  CustomersProvider() : super(kTableName);

  @override
  Customer fromMap(Map<String, dynamic> map) {
    return Customer.fromMap(map);
  }

  Future<Customer> addRandomRegister() async {
    final idx = itemsCount;
    final register = Customer.fromMap({
      'name': 'Customer ${idx + 1}',
      'address': randomString(idx),
    });
    return addRegister(register);
  }
}
