import 'package:flutter/material.dart';

var url = 'http://192.168.35.1:5000/predict';

class settingPage extends StatefulWidget {
  const settingPage({super.key});

  @override
  State<settingPage> createState() => _MysettingPageState();
}

class _MysettingPageState extends State<settingPage> {
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(); 
  }

  // Function<void> ChangeURL(){

  // }
}