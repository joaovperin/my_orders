import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:my_orders/utils/ui.dart';
import 'package:my_orders/widgets/app_more_buttons_container.dart';

import 'customer_model.dart';

class CustomerPage extends StatelessWidget {
  CustomerPage(this.title, {Key key}) : super(key: key);
  final String title;

  final List<Customer> _list = List<Customer>.generate(25, (idx) {
    return Customer.fromMap({
      'id': 1 + Random().nextInt(999),
      'name': 'Customer ${idx + 1}',
      'address': _generateRandomAddress(idx),
    });
  });

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
                  child: _customerList(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => actionNotImplemented(ctx, 'Novo Cliente'),
        tooltip: 'Novo Cliente',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _customerList() {
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (ctx, index) {
        final cr = _list[index];
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
  }

  Text _boldText(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  static String _generateRandomAddress(int id) {
    final rng = Random(128 * (32 + id * 250));
    final size = 5 + rng.nextInt(13);
    String text = String.fromCharCode(65 + rng.nextInt(25));
    for (var i = 1; i < size; i++) {
      text += String.fromCharCode(97 + rng.nextInt(25));
    }
    return text;
  }
}
