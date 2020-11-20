import 'package:my_orders/modules/customer/customer_model.dart';
import 'package:my_orders/utils/abstract_model.dart';
import 'package:my_orders/utils/string_utils.dart';

class CustomersProvider extends AbstractModelListProvider<Customer> {
  CustomersProvider() : super(CustomerDao());

  Customer fromMap(Map<String, dynamic> map) {
    return Customer.fromMap(map);
  }

  Future<Customer> addRandomRegister() async {
    final idx = count;
    final register = Customer.fromMap({
      'name': 'Customer ${idx + 1}',
      'address': randomString(idx),
    });
    return save(register);
  }
}
