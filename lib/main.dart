import 'package:flutter/material.dart';
import 'package:mandaditos_expres/src/pages/client/products/list/client_products_list_page.dart';
import 'package:mandaditos_expres/src/pages/client/update/client_update_page.dart';
import 'package:mandaditos_expres/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:mandaditos_expres/src/pages/login/login_page.dart';
import 'package:mandaditos_expres/src/pages/register/register_page.dart';
import 'package:mandaditos_expres/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:mandaditos_expres/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:mandaditos_expres/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:mandaditos_expres/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
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
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'roles': (BuildContext context) => RolesPage(),
        'client/products/list' : (BuildContext context) => ClientProductsListPage(),
        'client/update' : (BuildContext context) => ClientUpdatePage(),
        'delivery/orders/list' : (BuildContext context) => DeliveryOrdersListPage(),
        'restaurant/orders/list' : (BuildContext context) => RestaurantOrdersLitsPage(),
        'restaurant/categories/create' : (BuildContext context) => RestaurantCategoriesCreatePage(),
        'restaurant/products/create' : (BuildContext context) => RestaurantProductsCreatePage()
      },
      theme: ThemeData(
        fontFamily: 'NimbusSans',
        primaryColor: MyColors.primaryColor
      ),
    );
  }
}
