import 'package:flutter/material.dart';

class AppCancelSaveButtons extends StatelessWidget {
  final void Function() onClickSave;

  const AppCancelSaveButtons({
    Key key,
    this.onClickSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.pop(context),
        ),
        RaisedButton(
          onPressed: onClickSave,
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
