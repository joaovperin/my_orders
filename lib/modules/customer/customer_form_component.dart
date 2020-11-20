import 'package:flutter/material.dart';
import 'package:my_orders/utils/validators.dart';
import 'package:my_orders/widgets/app_cancel_save_buttons.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({Key key, this.onSubmit}) : super(key: key);

  final void Function(String, String) onSubmit;

  @override
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _adressCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Nome'),
                controller: _nameCtrl,
                validator: (value) => textMinSize(value, size: 3),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: 'Endereço'),
                validator: (value) => textNotEmpty(value),
                controller: _adressCtrl,
              ),
              AppCancelSaveButtons(onClickSave: _onSubmit),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    final String name = _nameCtrl.text.trim();
    final String address = _adressCtrl.text.trim();

    if (name.isEmpty || address.isEmpty) {
      return;
    }
    widget.onSubmit.call(name, address);
  }
}
