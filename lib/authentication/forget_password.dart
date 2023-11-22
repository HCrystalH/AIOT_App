import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ForgotPasswordPage extends StatefulWidget{
  const ForgotPasswordPage( {Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPassWordPageState();
}

class _ForgotPassWordPageState extends State<ForgotPasswordPage>{

  final _emailController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  /*

  */
  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
        showDialog(
          context: context, 
          builder: (context){
            return const AlertDialog(
              content:  Text('Password reset link sent! Check your email!'),
            );
          }
      );
    }on FirebaseAuthException catch(e){
      // print(e);
        showDialog(
          context: context, 
          builder: (context){
            return AlertDialog(
              // content:  Text('Error: ' + e.message.toString()),
              content: Text('Error: ' + e.message.toString()),
            );
          }
        );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child:  Text(
              'Enter Your Email and We will send a password reset link!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )
          ),
          
          // Email text field
          const SizedBox(height:10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
                fillColor: Colors.grey,
                filled: true,
              ),
            )
          ),
          const SizedBox(height:10),

          MaterialButton(
            onPressed: passwordReset,
            child: const Text('Reset Password'),
            color: Colors.deepPurple[200],
          ),
        ],
          
      ),
    );
  }
}