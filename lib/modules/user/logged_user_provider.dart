import 'package:flutter/widgets.dart';

class LoggedUserState {
  String name;

  bool diff(String oldName) {
    return oldName == null || name != oldName;
  }
}

class LoggedUserProvider extends InheritedWidget {
  final LoggedUserState state = LoggedUserState();

  LoggedUserProvider({Key key, Widget child}) : super(key: key, child: child);

  static LoggedUserProvider of(BuildContext ctx) => ctx.dependOnInheritedWidgetOfExactType<LoggedUserProvider>();

  String get name => state.name ?? 'Usuário';

  void login(String name) {
    this.state.name = name;
  }

  void logout() {
    this.state.name = null;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
