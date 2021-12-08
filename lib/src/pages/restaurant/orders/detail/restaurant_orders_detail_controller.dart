import 'package:flutter/material.dart';
import 'package:mandaditos_expres/src/models/order.dart';
import 'package:mandaditos_expres/src/models/product.dart';
import 'package:mandaditos_expres/src/utils/shared_pref.dart';

class RestaurantOrdersDetailController {
  BuildContext context;
  Function refresh;
  Product product;
  Order order;

  int counter = 1;
  double productPrice;

  SharedPref _sharedPref = new SharedPref();

  double total = 0;

  Future init(BuildContext context, Function refresh, Order order) async{
    this.context = context;
    this.refresh = refresh;
    this.order = order;

    getTotal();
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