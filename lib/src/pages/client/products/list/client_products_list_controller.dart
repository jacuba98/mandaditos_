import 'package:flutter/material.dart';
import 'package:mandaditos_expres/src/models/category.dart';
import 'package:mandaditos_expres/src/models/product.dart';
import 'package:mandaditos_expres/src/models/user.dart';
import 'package:mandaditos_expres/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:mandaditos_expres/src/provider/categories_provider.dart';
import 'package:mandaditos_expres/src/provider/products_provider.dart';
import 'package:mandaditos_expres/src/utils/shared_pref.dart';

class ClientProductListController {
  BuildContext context;
  Function refresh;
  User user;
  CategoriesProvider _categoriesProvider =  new CategoriesProvider();
  ProductsProvider _productsProvider =  new ProductsProvider();
  List<Category> categories = [];

  SharedPref _sharedPref =  new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _productsProvider.init(context, user);
    getCategories();
    refresh();
  }
  Future<List<Product>> getProducts(String idCategory) async{
    return await _productsProvider.getByCategory(idCategory);
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }

  void openBottomSheet(Product product){
    showModalBottomSheet(
        context: context,
        builder: (context) => ClientProductsDetailPageState(product: product)
    );
  }

  void logout() {
    _sharedPref.logout(context, user.id);
  }

  void openDrawer(){
    key.currentState.openDrawer();
  }

  void goToUpdatePage(){
    Navigator.pushNamed(context, 'client/update');
  }

  void goToRoles(){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }
}