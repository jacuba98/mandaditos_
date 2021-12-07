import 'package:flutter/material.dart';
import 'package:mandaditos_expres/src/models/category.dart';
import 'package:mandaditos_expres/src/models/user.dart';
import 'package:mandaditos_expres/src/provider/categories_provider.dart';
import 'package:mandaditos_expres/src/utils/shared_pref.dart';

class RestaurantOrdersListController {
  BuildContext context;
  SharedPref _sharedPref =  new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  User user;

  CategoriesProvider _categoriesProvider =  new CategoriesProvider();

  List<String> categories = ['PAGADO', 'DESPACHADO', 'EN CAMINO', 'ENTREGADO'];



  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    //getCatrgories();
    refresh();
  }


/*
  void getCatrgories() async{
    categories = await _categoriesProvider.getAll();
    refresh();
  }*/

  void logout() {
    _sharedPref.logout(context, user.id);
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
