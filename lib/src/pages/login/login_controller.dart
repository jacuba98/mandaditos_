import 'package:flutter/material.dart';
import 'package:mandaditos_expres/src/models/response_api.dart';
import 'package:mandaditos_expres/src/models/user.dart';
import 'package:mandaditos_expres/src/provider/user_provider.dart';
import 'package:mandaditos_expres/src/utils/my_snackbar.dart';
import 'package:mandaditos_expres/src/utils/shared_pref.dart';

class LoginController {

  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UserProvider userProvider = new UserProvider();
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context) async{
    this.context = context;
    await userProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    //print('Usuario: ${user.toJson()}');

    if(user?.sessionToken != null) {
      if (user.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      }
      else {
        Navigator.pushNamedAndRemoveUntil(context, user.roles[0].route, (route) => false);
      }
    }
  }

  void goToRegisterPage(){
    Navigator.pushNamed(context, 'register');
  }

  void login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await userProvider.login(email, password);

    print('Respuesta object: ${responseApi}');
    //print('Respuesta: ${responseApi.toJson()}');

    if(responseApi.success){
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());

      print('Usuario Logeado: ${user.toJson()}');
      if (user.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      }
      else {
        Navigator.pushNamedAndRemoveUntil(context, user.roles[0].route, (route) => false);
      }
    }
    else {
      MySnackbar.show(context, responseApi.message);
    }
  }
}