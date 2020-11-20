import 'package:badges/badges.dart';
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

class BadgeWidget extends StatelessWidget {
  final String textContent;
  final Icon icon;
  final Color textColor;
  final Color iconColor;

  const BadgeWidget(this.textContent, this.icon, {Key key, this.textColor = Colors.white, this.iconColor = Colors.red}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeColor: iconColor,
      showBadge: true,
      badgeContent: Text(
        textContent,
        style: TextStyle(fontSize: 12, color: textColor, backgroundColor: iconColor),
      ),
      child: icon,
    );
  }
}
