import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class AppBadgeWidget extends StatelessWidget {
  final String textContent;
  final Icon icon;
  final Color textColor;
  final Color iconColor;

  const AppBadgeWidget(this.textContent, this.icon, {Key key, this.textColor = Colors.white, this.iconColor = Colors.red}) : super(key: key);

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
