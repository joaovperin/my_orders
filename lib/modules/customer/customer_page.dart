import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:my_orders/utils/ui.dart';
import 'package:my_orders/widgets/app_more_buttons_container.dart';
import 'package:provider/provider.dart';

import 'customers_provider.dart';

class CustomerPage extends StatelessWidget {
  CustomerPage(this.title, {Key key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 80,
                child: Text(title),
              ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final pr = await Provider.of<CustomersProvider>(ctx, listen: false).addRandomRegister();
            showScaffold(ctx, 'Cliente ${pr.id}-${pr.name} adicionado com sucesso!');
          },
          tooltip: 'Novo Cliente',
          child: Icon(Icons.add),
        ));
  }

  Widget _customerList(BuildContext ctx) {
    return FutureBuilder(
      future: Provider.of<CustomersProvider>(ctx, listen: false).loadRegisters(),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? _loadingBar(ctx)
          : Consumer<CustomersProvider>(
              child: notFound(),
              builder: (context, provider, child) {
                // empty list
                if (provider.itemsCount == 0) {
                  return child;
                }
                return ListView.builder(
                  itemCount: provider.itemsCount,
                  itemBuilder: (ctx, index) {
                    final cr = provider.itemByIndex(index);
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
                            child: _boldText('# ${cr.id}'),
                          ),
                        ),
                      ),
                      title: _boldText(cr.name),
                      subtitle: Text(cr.address),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          AppMoreButtonsContainer(
                            menuItems: <FocusedMenuItem>[
                              FocusedMenuItem(
                                trailingIcon: Icon(Icons.delete),
                                title: const Text('Excluir'),
                                onPressed: () => actionNotImplemented(ctx, 'Excluir Cliente'),
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
}
