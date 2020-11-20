import 'package:flutter/material.dart';
import 'package:my_orders/utils/app-routes.dart';
import 'package:my_orders/utils/navigator.dart';
import 'package:my_orders/utils/ui.dart';
import 'package:my_orders/widgets/app_logo.dart';
import 'package:my_orders/widgets/app_title_text.dart';
import 'package:my_orders/widgets/app_user_menu.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);
  static const double kSuperiorContainerSize = 120;
  static const double kItemCardHeigth = 50;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [const AppUserMenu()],
      ),
      body: Column(
        children: [
          AppLogo(),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: _card(ctx),
            ),
          ),
        ],
      ),
    );
  }

  Card _card(BuildContext ctx) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const AppTitleText('Seja bem vindo!', height: kSuperiorContainerSize),
          _itemCard(ctx, 'Clientes', (_) => pushNamed(ctx, AppRoutes.CUSTOMER_LIST)),
          _itemCard(ctx, 'Produtos', (_) => pushNamed(ctx, AppRoutes.PRODUCT_LIST)),
          _itemCard(ctx, 'Pedidos', (name) => pageNotImplemented(ctx, name)),
        ],
      ),
    );
  }

  Widget _itemCard(BuildContext ctx, String text, Function(String) onTap) {
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
