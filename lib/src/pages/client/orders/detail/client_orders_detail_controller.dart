import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mandaditos_expres/src/models/order.dart';
import 'package:mandaditos_expres/src/models/product.dart';
import 'package:mandaditos_expres/src/models/response_api.dart';
import 'package:mandaditos_expres/src/models/user.dart';
import 'package:mandaditos_expres/src/provider/orders_provider.dart';
import 'package:mandaditos_expres/src/provider/user_provider.dart';
import 'package:mandaditos_expres/src/utils/my_snackbar.dart';
import 'package:mandaditos_expres/src/utils/shared_pref.dart';

class ClientOrdersDetailController {
  BuildContext context;
  Function refresh;
  Product product;
  Order order;

  int counter = 1;
  double productPrice;

  String idDelivery;

  User user;
  List<User> users = [];
  UserProvider _usersProvider = new UserProvider();
  SharedPref _sharedPref = new SharedPref();
  OrdersProvider _ordersProvider = new OrdersProvider();

  double total = 0;

  Future init(BuildContext context, Function refresh, Order order) async{
    this.context = context;
    this.refresh = refresh;
    this.order = order;
    user = User.fromJson(await _sharedPref.read('user'));
    _usersProvider.init(context, sessionUser: user);
    _ordersProvider.init(context, user);

    getTotal();
    getUsers();
    refresh();
  }

  void updateOrder() async{
    Navigator.pushNamed(context, 'client/orders/map', arguments: order.toJson());
  }

  void getUsers() async {
    users = await _usersProvider.getDeliveryMen();
    refresh();
  }

  void getTotal(){
    total = 0;
    order.products.forEach((product) {
      total = total + (product.price * product.quantity);
    });
    refresh();
  }
}