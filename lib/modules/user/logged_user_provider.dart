import 'package:flutter/foundation.dart';
import 'package:my_orders/modules/user/user_model.dart';

class LoggedUserProvider with ChangeNotifier {
  User loggerdUser;

  void login(User user) {
    this.loggerdUser = user;
    notifyListeners();
  }

  void logout() {
    this.loggerdUser = null;
    notifyListeners();
  }

  User fromMap(Map<String, dynamic> map) {
    return User.fromMap(map);
  }
}
