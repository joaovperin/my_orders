import 'package:flutter/material.dart';
import 'package:my_orders/modules/home_page.dart';
import 'package:my_orders/utils/navigator.dart';
import 'package:my_orders/modules/user/logged_user_provider.dart';
import 'package:my_orders/utils/ui.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  final _tNome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          _buildText(ctx, "Nome", ctrl: _tNome),
          SizedBox(height: 20),
          _button(ctx, "Login", _onClickLogin),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context, String label, {String hint, bool hide = false, TextEditingController ctrl}) {
    return TextFormField(
      controller: ctrl,
      obscureText: hide,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint ?? "Digite o campo ${label.toLowerCase()}",
      ),
    );
  }

  _button(BuildContext context, String text, Function onPressed) {
    return Container(
      height: 46,
      child: RaisedButton(
        child: Text(text),
        onPressed: () => onPressed.call(context),
      ),
    );
  }

  void _onClickLogin(BuildContext context) async {
    final name = _tNome.text.trim();
    if (name.isEmpty) {
      showSnackbar(context, 'É necessário informar seu nome!');
      return;
    }

    LoggedUserProvider.of(context).login(name);
    push(context, MyHomePage());
  }
}
