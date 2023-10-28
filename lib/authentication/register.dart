import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';
import 'package:my_flutter_app/authentication/login_page.dart';

enum RegistrationResult { success, failure }


// Define a custom Form widget
class RegisterForm extends StatefulWidget {
    const RegisterForm({super.key});

    @override
    RegisterFormState createState(){
      return RegisterFormState();
    }
}

// Define a corressponding State class
// This class holds data related to the form
class RegisterFormState extends State<RegisterForm>{
  
  final AuthService _auth = AuthService();

  // This is a GlobalKey<FormState> NOT GlobalKey<RegisterFormState>
  final _formKey = GlobalKey<FormState>();

  //Text field state
  String email = '';
  String password = '';
  String error = '';
  // Declare TextEditingController as an instance variable
  // final _passwordController = TextEditingController();
  // final _confirmPasswordController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0.0,
        title: const Text('Sign in to Counting app'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        // Testing
        child: Form(
          key: _formKey,  /*local key*/
          child: Column(
            children: <Widget>[
              // This box for username 
              const SizedBox(height: 20.0),
              TextFormField(
                decoration:  const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if(value != null && value.isEmpty){
                    return 'Please enter your email';
                  }else if(value != null && !value.isValidEmail()){
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged:(value){
                  setState(() => email = value);
                },
              ),
              
              // This box for password 
              const SizedBox(height:20.0),
              TextFormField(
                decoration:  const InputDecoration(labelText: 'Password'),
                obscureText: true,
                // controller: _passwordController,
                validator: (value) => value!.length <8 ? 'Password must at least 8 characters ': null,
                onChanged: (value){
                  setState(() => password = value);
                },
              ),
              
              // This box for confirm password 
              const SizedBox(height:20.0),
              TextFormField(
                decoration:  const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                // controller: _confirmPasswordController,
                validator: (value){
                  if(value == null){
                    return 'Password does not match';
                  }else if(value != password){
                    return 'Password does not match';
                  }
                  return null;
                },
                onChanged: (value){
                  setState(() => password = value);
                },
              ),
              
              const SizedBox(height: 20.0),
              /* RaisedButton => ElevatedButton
              Sign up button
              */ 
              ElevatedButton(
                child: const Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed:() async {
                  //_formKey.currentState! : to make sure that it's not null
                  if(_formKey.currentState!.validate()){
                    dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                    if(result == null){
                      setState( () => error ='Please supply a valid email');
                    }
                  }
                }
              ),
              
              //Box for error messages
              const SizedBox(height: 20.0),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                ),

              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text(
                  'Already have account? Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed:() async {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context)=> const LoginPage())
                    );
                }
              )
            ],
          ),
        ),
      )
    );
  }
 
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}