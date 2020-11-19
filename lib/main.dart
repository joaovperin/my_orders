import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules//home_page.dart';
import 'modules/customer/customer_page.dart';
import 'modules/login_page.dart';
import 'modules/product/product_page.dart';
import 'modules/product/products_provider.dart';
import 'utils/app-routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kAppThemeData = _buildThemeData(context);
    return MaterialApp(
      title: 'My Orders',
      debugShowCheckedModeBanner: false,
      theme: kAppThemeData,
      initialRoute: '/login',
      routes: {
        AppRoutes.HOME_PAGE: (ctx) => MyHomePage(),
        AppRoutes.LOGIN_PAGE: (ctx) => LoginPage(),
        AppRoutes.PRODUCT_LIST: (ctx) => ChangeNotifierProvider(
              create: (ctx) => ProductsProvider(),
              child: ProductPage('Produtos'),
            ),
        AppRoutes.CUSTOMER_LIST: (ctx) => CustomerPage('Clientes'),
      },
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.orange[400],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      primaryColorLight: Colors.yellow[300],
      primaryColorDark: Colors.amber,
      accentColor: Colors.amber,
      canvasColor: Colors.yellow[300],
      iconTheme: IconThemeData(
        color: Colors.orange,
      ),
      backgroundColor: Colors.yellow[200],
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.orange[800]),
        bodyText2: TextStyle(color: Colors.orange[800], fontSize: 22),
        button: TextStyle(color: Colors.white, fontSize: 18),
        // input titles
        subtitle1: TextStyle(fontSize: 22),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 14),
        helperStyle: TextStyle(color: Colors.blue),
        prefixStyle: TextStyle(color: Colors.blue),
        suffixStyle: TextStyle(color: Colors.blue),
        labelStyle: TextStyle(fontSize: 18),
      ),
      cardTheme: CardTheme(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.orange,
        textTheme: ButtonTextTheme.accent,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: Colors.white,
            ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: TextButton.styleFrom(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.amber,
      ),
    );
  }
}
