import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:my_orders/utils/ui.dart';
import 'package:my_orders/widgets/app_more_buttons_container.dart';
import 'package:my_orders/widgets/app_title_text.dart';
import 'package:my_orders/widgets/app_user_menu.dart';
import 'package:provider/provider.dart';

import 'orders_provider.dart';

class OrderPage extends StatelessWidget {
  static const title = 'Pedidos';

  OrderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        actions: [const AppUserMenu()],
      ),
      body: Center(
        child: Column(
          children: [
            const AppTitleText(title),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(2),
                width: double.infinity,
                child: Card(
                  child: _customerList(ctx),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _addNovoRegistro(ctx),
            tooltip: 'Novo Cliente',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _customerList(BuildContext ctx) {
    return FutureBuilder(
      future: Provider.of<OrdersPageProvider>(ctx, listen: false).loadList(),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? _loadingBar(ctx)
          : Consumer<OrdersPageProvider>(
              child: notFound(),
              builder: (context, provider, child) {
                // empty list
                if (provider.count == 0) {
                  return child;
                }
                return ListView.builder(
                  itemCount: provider.count,
                  itemBuilder: (ctx, index) {
                    final order = provider.getByIndex(index);
                    final entryDate = provider.fmtEntryDate(order);
                    final totalValue = provider.fmtTotalValue(order);

                    return ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(ctx).backgroundColor,
                          border: Border.all(
                            color: Theme.of(ctx).accentColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(4),
                        child: SizedBox(
                          height: 40,
                          width: 60,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: _boldText('# ${order.id}'),
                          ),
                        ),
                      ),
                      title: _boldText(entryDate),
                      subtitle: Text(totalValue),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          AppMoreButtonsContainer(
                            menuItems: <FocusedMenuItem>[
                              FocusedMenuItem(
                                trailingIcon: Icon(Icons.delete),
                                title: const Text('Excluir'),
                                onPressed: () => actionNotImplemented(ctx, 'Excluir Pedido'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  Text _boldText(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _loadingBar(BuildContext ctx) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void _addNovoRegistro(BuildContext ctx) {
    actionNotImplemented(ctx, 'Adicionar pedido');
  }
}
