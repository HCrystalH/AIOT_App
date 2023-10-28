import 'package:flutter/material.dart';
import 'package:my_flutter_app/authentication/login_page.dart';

@immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}