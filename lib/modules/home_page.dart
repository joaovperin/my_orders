import 'package:flutter/material.dart';
import 'package:my_orders/utils/app-routes.dart';
import 'package:my_orders/utils/navigator.dart';
import 'package:my_orders/utils/ui.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    const double kSuperiorContainerSize = 140;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: kSuperiorContainerSize),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: _card(ctx),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _card(BuildContext ctx) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _itemCard(ctx, 'Clientes', (_) => pushNamed(ctx, AppRoutes.CUSTOMER_LIST)),
          _itemCard(ctx, 'Produtos', (_) => pushNamed(ctx, AppRoutes.PRODUCT_LIST)),
          _itemCard(ctx, 'Pedidos', (name) => pageNotImplemented(ctx, name)),
        ],
      ),
    );
  }

  Widget _itemCard(BuildContext ctx, String text, Function(String) onTap) {
    const double kItemCardHeigth = 50;
    return GestureDetector(
      onTap: () => onTap.call(text),
      child: Card(
        child: Container(
          height: kItemCardHeigth,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(text),
        ),
      ),
    );
  }
}
