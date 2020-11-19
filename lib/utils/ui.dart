import 'package:flutter/material.dart';

ScaffoldMessengerState actionNotImplemented(BuildContext ctx, String name) {
  return showScaffold(ctx, 'Ação "$name" não implementada!');
}

ScaffoldMessengerState pageNotImplemented(BuildContext ctx, String name) {
  return showScaffold(ctx, 'Página "$name" não implementada!');
}

ScaffoldMessengerState showScaffold(BuildContext ctx, String message) {
  return ScaffoldMessenger.of(ctx)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      duration: const Duration(seconds: 4),
      content: Text(message),
      behavior: SnackBarBehavior.fixed,
    ));
}

Column notFound({String message = 'Nenhum registro encontrado :/'}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        child: Text(':(', style: TextStyle(fontSize: 24)),
        radius: 30,
      ),
      SizedBox(height: 10),
      Text(message),
    ],
  );
}
