import 'package:flutter/material.dart';
import 'package:my_orders/utils/app-routes.dart';
import 'package:my_orders/utils/navigator.dart';

enum AppUserMenuAction {
  LOGOUT,
}

class AppUserMenu extends StatelessWidget {
  const AppUserMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (AppUserMenuAction action) {
        if (action == AppUserMenuAction.LOGOUT) {
          pushNamed(context, AppRoutes.LOGIN_PAGE, replace: true);
        }
      },
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) => [
        PopupMenuItem(
          value: AppUserMenuAction.LOGOUT,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Logout'),
              const Icon(Icons.logout),
            ],
          ),
        ),
      ],
    );
  }
}
