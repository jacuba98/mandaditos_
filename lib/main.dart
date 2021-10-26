import 'package:flutter/material.dart';
import 'package:mandaditos_expres/src/login/login_page.dart';
import 'package:mandaditos_expres/src/register/register_page.dart';
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
        'login': (BuildContext context) => loginpage(),
        'register': (BuildContext context) => RegisterPage()
      },
      theme: ThemeData(
        fontFamily: 'NimbusSans',
        primaryColor: MyColors.primaryColor
      ),
    );
  }
}
