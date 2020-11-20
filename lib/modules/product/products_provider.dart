import 'dart:math';

import 'package:my_orders/modules/product/product_model.dart';
import 'package:my_orders/utils/abstract_model.dart';
import 'package:my_orders/utils/string_utils.dart';

class ProductsProvider extends AbstractModelListProvider<Product> {
  ProductsProvider() : super(ProductDao());

  Future<Product> addRandomRegister() async {
    final idx = count;
    final register = Product.fromMap({
      'description': 'Product ${idx + 1}',
      'reference': randomString(idx),
      'value': 50 + 300 * Random().nextDouble(),
    });
    return save(register);
  }
}
