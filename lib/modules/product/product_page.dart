import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:my_orders/modules/product/products_provider.dart';
import 'package:my_orders/utils/number-utils.dart';
import 'package:my_orders/utils/ui.dart';
import 'package:my_orders/widgets/app_more_buttons_container.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  ProductPage(this.title, {Key key}) : super(key: key);
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
                  child: _productList(ctx),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pr = await Provider.of<ProductsProvider>(ctx, listen: false).addRandomRegister();
          showScaffold(ctx, 'Produto ${pr.id}-${pr.description} adicionado com sucesso!');
        },
        tooltip: 'Novo Produto',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _productList(BuildContext ctx) {
    return FutureBuilder(
      future: Provider.of<ProductsProvider>(ctx, listen: false).loadRegisters(),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? _loadingBar(ctx)
          : Consumer<ProductsProvider>(
              child: notFound(),
              builder: (context, provider, child) {
                // empty list
                if (provider.itemsCount == 0) {
                  return child;
                }
                return ListView.builder(
                  itemCount: provider.itemsCount,
                  itemBuilder: (ctx, index) {
                    final product = provider.itemByIndex(index);
                    return ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(ctx).backgroundColor,
                          border: Border.all(
                            color: Theme.of(ctx).accentColor,
                            width: 2,
                          ),
                        ),
                        child: SizedBox(
                          height: 40,
                          width: 80,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: _boldText(fmtMoney(product.value)),
                          ),
                        ),
                      ),
                      title: _boldText(product.description),
                      subtitle: Text(product.reference),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          AppMoreButtonsContainer(
                            menuItems: <FocusedMenuItem>[
                              FocusedMenuItem(
                                trailingIcon: Icon(Icons.delete),
                                title: const Text('Excluir'),
                                onPressed: () async {
                                  await Provider.of<ProductsProvider>(ctx, listen: false).removeProduct(product);
                                  showScaffold(ctx, 'O produto ${product.id}-${product.description} foi removido.');
                                },
                              ),
                            ],
                          )
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
