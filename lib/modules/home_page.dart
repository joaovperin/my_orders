import 'package:flutter/material.dart';
import 'package:my_orders/modules/user/logged_user_provider.dart';
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
          const AppLogo(),
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
    final LoggedUserProvider userProvider = LoggedUserProvider.of(ctx);
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AppTitleText('Seja bem vindo, ${userProvider.name}', height: kSuperiorContainerSize),
          _itemCard(ctx, 'Clientes', () => pushNamed(ctx, AppRoutes.CUSTOMER_LIST)),
          _itemCard(ctx, 'Produtos', () => pushNamed(ctx, AppRoutes.PRODUCT_LIST)),
          _itemCard(ctx, 'Pedidos', () => pushNamed(ctx, AppRoutes.ORDER_LIST)),
        ],
      ),
    );
  }

  Widget _itemCard(BuildContext ctx, String text, GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
