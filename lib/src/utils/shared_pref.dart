import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter_delivery_udemy/src/provider/user_provider.dart';//UserProvider
import 'package:mandaditos_expres/src/provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  void save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(key) == null) return null;

    return json.decode(prefs.getString(key));
  }

  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  void logout(BuildContext context, String idUser) async {
    UserProvider userProvider = new UserProvider();
    userProvider.init(context);
    await userProvider.logout(idUser);
    await remove('user');
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }

}