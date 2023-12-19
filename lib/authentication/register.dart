import 'auth.dart';
import 'package:my_flutter_app/authentication/login_page.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
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
  String confirmPassword ='';
  String error = '';
  String message= '';
  
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
        child: Padding(

        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        // Testing
        child: Form(
          key: _formKey,  /*local key*/
          child: Column(
            children: <Widget>[
              // This box for username 
              const SizedBox(height: 20.0),
              Image.asset('assets/user.png', height: 60, width: 60,),

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
                // obscureText: true,
                // controller: _passwordController,
                validator: (value) => value!.length <8 ? 'Password must at least 8 characters ': null,
                onChanged: (value){
                  setState(() => password = value);
                  setState(() => confirmPassword = value);
                },
              ),
              
              // This box for confirm password 
              const SizedBox(height:20.0),
              TextFormField(
                decoration:  const InputDecoration(labelText: 'Confirm Password'),
                // obscureText: true,
                // controller: _confirmPasswordController,
                validator: (value){
                  if(value == null){
                    return 'Password does not match';
                  }else if(value != confirmPassword){
                    return 'Password does not match';
                  }else {return null;}
                  
                },
                // onChanged: (value){
                //   setState(() => password = value);
                // },
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
                  //_formKey.currentState? : to make sure that it's not null
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState?.save();

                    dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                    // UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                    // User? user = result.user;
                    // await FirebaseFirestore.instance.collection('User').doc(user?.uid).set({
                    //   'username': email,
                    //   'password': password,
                    // });
                    if(result ==null){
                      setState( () => error ='Please enter information correctly!');
                    }else if(result != null){
                      setState( () => message ='Sucessful Registration!');
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context)=> const LoginPage())
                      );
                    }
                  }
                  else {setState( () => error ='Please enter full fields and correct information!');}
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