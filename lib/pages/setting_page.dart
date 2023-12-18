import 'package:flutter/material.dart';

var url ='http://192.168.35.1:5000/predict';

class settingPage extends StatefulWidget {
  const settingPage({super.key});

  @override
  State<settingPage> createState() => _MysettingPageState();
}

class _MysettingPageState extends State<settingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting Page"),         
      backgroundColor: const Color.fromARGB(255, 132, 181, 53), // Use the RGB value for matcha
      )
    ); 
  }

  // Function<void> ChangeURL(){

  // }
}