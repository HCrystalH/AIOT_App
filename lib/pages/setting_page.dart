import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/authentication/login_page.dart';
import 'package:my_flutter_app/authentication/auth.dart';
import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/services/database.dart';


var url = 'http://192.168.35.1:5000/predict';

class settingPage extends StatefulWidget {
  // const MyWidget({super.key});

  @override
  State<settingPage> createState() => _MysettingPageState();
}

class _MysettingPageState extends State<settingPage> {
  TextEditingController urlController = TextEditingController();

  String _currentPassword = '';
  String _newPassword ='';
  String _cfirmNewPassword ='';
  String message = '';
  bool checkPassword = false;
  bool _show = false;
  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  
  final AuthService _auth = AuthService();
  

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 0, 10),
              child: Text(
                'Connect by type your URL here: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
              child: Column(
                children: [
                  TextField(
                    controller: urlController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 5),
                  const Text(
                    'Enter or modify the existing URL and click "Change" to update.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Check if the text field is not empty
                  if (urlController.text.isNotEmpty) {
                    setState(() {
                      url = urlController.text;
                    });
                  }
                },
                child: Text('Change'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 0, 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const TextSpan(
                      text: 'The existing URL: \n',
                      style: TextStyle(
                        color: Colors.black, 
                      ),
                    ),
                    TextSpan(
                      text: url,
                      style: const TextStyle(
                        color: Colors.red, 
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Change Password
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
            //   child: Form(
            //     key: _formKey,
            //     child: Column(
            //       children: <Widget>[
            //         const SizedBox(height:20.0),
            //         TextFormField(
            //           decoration:  InputDecoration(labelText: 'Current Password'),
            //           validator: (value) => checkPassword ? 'Incorrect Password !!!': null,
            //           onChanged: (value){
            //             setState(() {
            //               _currentPassword = value;
            //             });
            //           },
            //         ),
            //         TextFormField(
            //           decoration:  InputDecoration(labelText: 'New Password'),
            //           validator: (value) => _newPassword.length >8 ? 'Password length must be greater than 8 characters': null,
            //           onChanged: (value){
            //             setState(() {
            //               _newPassword = value;
            //               _cfirmNewPassword = value;
            //             });
            //           },
            //         ),
            //         TextFormField(
            //           decoration:  const InputDecoration(labelText: 'Confirm New Password'),
            //           validator: (value){
            //             if(value == null) return 'Password does not match!';
            //             else if (value != _cfirmNewPassword) return 'Password does not match!';
            //             else return null;
            //           } 
            //         ),
                    
            //         //CHANGE PASSWORD BUTTON
            //         const SizedBox(height: 20.0),
            //         ElevatedButton(
            //           child: const Text(
            //             'Change Password',
            //             style: TextStyle(color: Colors.white),
            //           ),
            //           onPressed:() async {
            //             /*_formKey.currentState? : to make sure that it's not null
            //               validating form
            //             */
            //             if(_formKey.currentState!.validate()){
            //               _formKey.currentState?.save();

            //               // debugPrint('$email & $_newPassword');
            //               // debugPrint('$_uid');
                          
            //               if(_cfirmNewPassword != _newPassword){
            //                 debugPrint("SOMETHING");
            //                 setState( () => message ='Please enter information correctly!');
            //               }else{
            //                 debugPrint("SUCCESS");
                            
            //                 // await DatabaseService(uid:_uid).updatePassword(_cfirmNewPassword);
            //                 await DatabaseService(uid:_uid).updateUserData(email,_cfirmNewPassword);
            //                 setState( () => message ='Sucessful Change Password!');
            //               }
            //             }
            //             else {setState( () => message ='Please enter full fields and correct information!');}
            //           }
            //         ),

            //             //This box to show error message
            //         Padding(
            //           padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            //           child: SizedBox(
            //             height: _show ? 12 : 0,
            //             child: Text(
            //               message,
            //               style: const TextStyle(color: Colors.red, fontSize: 12.0),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<bool> CheckPassword(String _password) async{
    dynamic result = await _auth.signInWithEmailAndPassword(email, _password);
    if(result != null) checkPassword = true;
    else checkPassword = false;

    return false;
  }
}
