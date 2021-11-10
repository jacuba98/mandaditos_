import 'package:flutter/material.dart';
import 'package:mandaditos_expres/src/pages/client/products/list/client_products_list_page.dart';
import 'package:mandaditos_expres/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:mandaditos_expres/src/pages/login/login_page.dart';
import 'package:mandaditos_expres/src/pages/register/register_page.dart';
import 'package:mandaditos_expres/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:mandaditos_expres/src/pages/roles/roles_page.dart';
import 'package:mandaditos_expres/src/utils/my_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App Flutter',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => loginpage(),
        'register': (BuildContext context) => RegisterPage(),
        'roles': (BuildContext context) => RolesPage(),
        'client/products/list' : (BuildContext context) => ClientProductsListPage(),
        'delivery/orders/list' : (BuildContext context) => DeliveryOrdersListPage(),
        'restaurant/orders/list' : (BuildContext context) => RestaurantOrdersLitsPage()
      },
      theme: ThemeData(
        fontFamily: 'NimbusSans',
        primaryColor: MyColors.primaryColor
      ),
    );
  }
}
