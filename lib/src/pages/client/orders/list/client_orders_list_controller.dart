import 'package:flutter/material.dart';
import 'package:mandaditos_expres/src/models/category.dart';
import 'package:mandaditos_expres/src/models/order.dart';
import 'package:mandaditos_expres/src/models/user.dart';
import 'package:mandaditos_expres/src/pages/client/orders/detail/client_orders_detail_page.dart';
import 'package:mandaditos_expres/src/pages/delivery/orders/detail/restaurant_orders_detail_page.dart';
import 'package:mandaditos_expres/src/provider/categories_provider.dart';
import 'package:mandaditos_expres/src/provider/orders_provider.dart';
import 'package:mandaditos_expres/src/pages/restaurant/orders/detail/restaurant_orders_detail_page.dart';
import 'package:mandaditos_expres/src/utils/shared_pref.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientOrdersListController {
  BuildContext context;
  SharedPref _sharedPref =  new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  User user;

  bool isUpdated;

  OrdersProvider _ordersProvider =  new OrdersProvider();

  List<String> status = ['PAGADO', 'DESPACHADO', 'EN CAMINO', 'ENTREGADO'];



  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _ordersProvider.init(context, user);
    //getCatrgories();
    refresh();
  }

  Future<List<Order>> getOrders(String status) async{
    return await _ordersProvider.getByClientAndStatus(user.id, status);
  }


/*
  void getCatrgories() async{
    categories = await _categoriesProvider.getAll();
    refresh();
  }*/

  void logout() {
    _sharedPref.logout(context, user.id);
  }

  void openBottomSheet(Order order) async{
    isUpdated = await showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientOrdersDetailPage(order: order)
    );

    if(isUpdated){
      refresh();
    }
  }

  void goToCategoryCreate(){
    Navigator.pushNamed(context, 'restaurant/categories/create');
  }

  void goToProductosCreate(){
    Navigator.pushNamed(context, 'restaurant/products/create');
  }

  void openDrawer(){
    key.currentState.openDrawer();
  }

  void goToRoles(){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

}
