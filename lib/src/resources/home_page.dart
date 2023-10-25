import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/resources/login_page.dart';
import 'package:my_flutter_app/src/resources/sign_in.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// class HomePage extends StatefulWidget {

//   @override
//   State<HomePage> createState() => _MyHomeState();
// }

// class _MyHomeState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Home Page"),
//       ),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),
      ),
      body: Center(
      child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    child: Text('SIGN OUT'),
                    style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    backgroundColor: Colors.blue,
                     textStyle: const TextStyle(
                    color: Colors.white,
                     fontSize: 15, 
                     fontStyle: FontStyle.normal),
                     ),
                      onPressed:(){ 
                        signOutGoogle();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));


                      }
                  ),
                ),
              ),
            ]
        ),
      )
      
    );
  }
}
