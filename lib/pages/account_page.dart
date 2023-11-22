import 'package:flutter/material.dart';

class accountPage extends StatefulWidget {

  @override
  State<accountPage> createState() => _MyaccountPageState();
}

class _MyaccountPageState extends State<accountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Account Page!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your button press logic here
                print('Button Pressed!');
              },
              child: Text('Press Me'),
            ),
          ],
        ),
      ),
    );
  }
}