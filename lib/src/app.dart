import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/resources/login_page.dart';
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}