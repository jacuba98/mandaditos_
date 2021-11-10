import 'package:flutter/material.dart';
import 'package:mandaditos_expres/src/models/response_api.dart';
import 'package:mandaditos_expres/src/models/user.dart';
import 'package:mandaditos_expres/src/provider/user_provider.dart';
import 'package:mandaditos_expres/src/utils/my_snackbar.dart';

class RegisterController {

  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UserProvider userProvider = UserProvider();

  Future init(BuildContext context) {
    this.context = context;
    userProvider.init(context);
  }

  void register() async{
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmpassword = confirmPasswordController.text.trim();

    if(email.isEmpty || name.isEmpty || lastname.isEmpty || phone.isEmpty || password.isEmpty || confirmpassword.isEmpty){
      MySnackbar.show(context, '¡Debes ingresar todos los campos!');
      return;
    }

    if(confirmpassword != password ){
      MySnackbar.show(context, '¡Las contraseñas no coinciden!');
      return;
    }

    if(password.length < 8){
      MySnackbar.show(context, '¡La contraseña debe de tener al menos 8 caracteres!');
      return;
    }

    User user = new User(
      email: email,
      name: name,
      lastname: lastname,
      phone: phone,
      password: password
    );

    ResponseApi responseApi = await userProvider.create(user);

    MySnackbar.show(context, responseApi.message);

    if (responseApi.success) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, 'login');
      });
    }

    print('RESPUESTA: ${responseApi.toJson()}');

  }
  void back(){
    Navigator.pop(context);
  }
}