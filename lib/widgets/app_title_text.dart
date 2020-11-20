import 'package:flutter/material.dart';

class AppTitleText extends StatelessWidget {
  final String text;

  const AppTitleText(
    this.text, {
    Key key,
    this.height = 80,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Center(
        child: Text(text, style: const TextStyle(fontSize: 32)),
      ),
    );
  }
}
