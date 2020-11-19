import 'package:flutter/material.dart';

Future<dynamic> push(
  BuildContext context,
  Widget page, {
  bool replace = false,
}) async {
  _beforeNavigation(context);
  final kPageRoute = MaterialPageRoute(
    builder: (BuildContext ctx) => page,
  );
  if (replace) {
    return Navigator.pushReplacement(context, kPageRoute);
  }
  return Navigator.push(context, kPageRoute);
}

Future<dynamic> pushNamed(
  BuildContext context,
  String routeName, {
  bool replace = false,
}) async {
  _beforeNavigation(context);
  if (replace) {
    return Navigator.pushReplacementNamed(context, routeName);
  }
  return Navigator.pushNamed(context, routeName);
}

void _beforeNavigation(BuildContext context) {
  ScaffoldMessenger.of(context)..hideCurrentSnackBar();
}
