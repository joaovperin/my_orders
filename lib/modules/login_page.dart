import 'package:flutter/material.dart';
import 'package:my_orders/modules/home_page.dart';
import 'package:my_orders/utils/api.dart';
import 'package:my_orders/utils/navigator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();

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
          _buildText(ctx, "Login", ctrl: _tLogin),
          SizedBox(height: 10),
          _buildText(ctx, "Senha", ctrl: _tSenha, hide: true),
          SizedBox(height: 20),
          _button(ctx, "Login", _onClickLogin),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context, String label,
      {String hint, bool hide = false, TextEditingController ctrl}) {
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
    String login = _tLogin.text;
    String senha = _tSenha.text;

    bool ok = await ApiUtils.login(login, senha);

    print("Login: $login, Senha: $senha");
    if (ok) {
      push(context, MyHomePage());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Credenciais inválidas!'),
      ));
    }
  }
}
