import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'modules/home_page.dart';
import 'modules/order/order_page.dart';
import 'modules/order/orders_provider.dart';
import 'modules/user/logged_user_provider.dart';
import 'modules/customer/customer_page.dart';
import 'modules/customer/customers_provider.dart';
import 'modules/login_page.dart';
import 'modules/product/product_page.dart';
import 'modules/product/products_provider.dart';
import 'utils/app-routes.dart';

Future<void> main() async {
  Intl.defaultLocale = 'pt_BR';
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kAppThemeData = _buildThemeData(context);
    return MaterialApp(
      title: 'My Orders',
      debugShowCheckedModeBanner: true,
      theme: kAppThemeData,
      home: AppRouter(),
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
        style: TextButton.styleFrom(
          primary: Colors.orange,
        ),
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

class AppRouter extends StatelessWidget {
  AppRouter({
    Key key,
  }) : super(key: key);

// Definição das rotas da aplicação
  Map get routes => {
        // Home (módulos)
        AppRoutes.HOME_PAGE: (ctx) => MyHomePage(),
        // Login
        AppRoutes.LOGIN_PAGE: (ctx) => LoginPage(),
        // Listagem de produtos
        AppRoutes.PRODUCT_LIST: (ctx) => ChangeNotifierProvider(
              create: (ctx) => ProductsProvider(),
              child: ProductPage(),
            ),
        // Listagem de clientes
        AppRoutes.CUSTOMER_LIST: (ctx) => ChangeNotifierProvider(
              create: (ctx) => CustomersProvider(),
              child: CustomerPage(),
            ),
        // Listagem de pedidos
        AppRoutes.ORDER_LIST: (ctx) => ChangeNotifierProvider(
              create: (ctx) => OrdersPageProvider(),
              child: OrderPage(),
            ),
      };

  @override
  Widget build(BuildContext context) {
    return LoggedUserProvider(
      child: Navigator(
        // Rota inicial
        initialRoute: AppRoutes.HOME_PAGE,
        onGenerateRoute: (settings) {
          final routeName = settings.name;
          // Se a rota existir
          if (routes.containsKey(routeName)) {
            return MaterialPageRoute(builder: routes[routeName]);
          }
          // Rota padrão: página não encontrada
          return MaterialPageRoute(
            builder: (context) => Center(
              child: const Text('Página não encontrada!'),
            ),
          );
        },
      ),
    );
  }
}
