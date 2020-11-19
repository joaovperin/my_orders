import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class AppMoreButtonsContainer extends StatelessWidget {
  final List<FocusedMenuItem> menuItems;

  const AppMoreButtonsContainer({Key key, this.menuItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final holder = FocusedMenuHolder(
      blurSize: 0,
      menuWidth: MediaQuery.of(context).size.width * .5,
      blurBackgroundColor: Colors.black,
      duration: Duration(microseconds: 500),
      onPressed: () {},
      menuItems: menuItems,
      child: IconButton(
        icon: Icon(Icons.more_vert_rounded),
        color: Theme.of(context).accentColor,
        onPressed: () {},
      ),
    );
    return holder;
  }
}
