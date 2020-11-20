import 'package:flutter/material.dart';
import 'package:my_orders/utils/number-utils.dart';
import 'package:my_orders/widgets/app_cancel_save_buttons.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({Key key, this.onSubmit}) : super(key: key);

  final void Function(String, String, double) onSubmit;

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final TextEditingController _descriptionCtrl = TextEditingController();
  final TextEditingController _referenceCtrl = TextEditingController();
  final TextEditingController _valueCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Descrição'),
              controller: _descriptionCtrl,
              onSubmitted: (_) => _onSubmit(),
            ),
            TextField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Referência'),
              controller: _referenceCtrl,
              onSubmitted: (_) => _onSubmit(),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Valor (${getCurrency()})',
              ),
              controller: _valueCtrl,
              onSubmitted: (_) => _onSubmit(),
            ),
            AppCancelSaveButtons(onClickSave: _onSubmit),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    final String description = _descriptionCtrl.text.trim();
    final String reference = _valueCtrl.text.trim();
    final double value = double.tryParse(_valueCtrl.text.trim()) ?? 0;

    if (description.isEmpty || reference.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit.call(description, reference, value);
  }
}
