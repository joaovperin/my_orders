import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 180,
        width: 320,
        child: Image.asset(
          'assets/logo.png',
        ),
      ),
    );
  }
}
