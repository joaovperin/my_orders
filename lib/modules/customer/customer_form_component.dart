import 'package:flutter/material.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({Key key, this.onSubmit}) : super(key: key);

  final void Function(String, double, DateTime) onSubmit;

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<CustomerForm> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _valueCtrl = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              controller: _titleCtrl,
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
            Row(children: <Widget>[
              Text(_selectedDate == null ? 'Nenhuma data selecionada!' : fmtDateTime(_selectedDate)),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                onPressed: _onSelectDate,
                child: Text('Selecionar data'),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Theme.of(context).buttonTheme.colorScheme.primary,
                  textColor: Theme.of(context).buttonTheme.colorScheme.secondary,
                  onPressed: _onSubmit,
                  child: Text('Nova Transação'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSelectDate() async {
    final DateTime now = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: now.add(Duration(days: 30)),
    ).then((DateTime value) {
      if (value != null) {
        setState(() => _selectedDate = value);
      }
    });
  }

  void _onSubmit() {
    final String title = _titleCtrl.text.trim();
    final double value = double.tryParse(_valueCtrl.text.trim()) ?? 0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit.call(title, value, _selectedDate);
  }
}
