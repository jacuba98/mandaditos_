import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaditos_expres/src/models/user.dart';
import 'package:mandaditos_expres/src/utils/shared_pref.dart';

class RolesController {
  BuildContext context;
  Function refresh;
  User user;
  SharedPref sharedPref = new SharedPref();


  Future init(BuildContext context, Function refresh)async {
    this.context = context;
    this.refresh = refresh;
    
    user =  User.fromJson(await sharedPref.read('user'));//obteniendo el usuario de sesion actual
    refresh();
  }

  void goToPage(String route){
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }
}