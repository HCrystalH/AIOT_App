import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum RegistrationResult { success, failure }

Future<RegistrationResult> registerUser(String email, String password, String name) async {
  try {
    // Step 1: Create a user in Firebase Authentication
    final authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  
    // Step 2: Store user data in Firestore 
    // await FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set({
    //   'email': email,
    //   'name': name,
    // });
    
    return RegistrationResult.success;
  } catch (e) {
    debugPrint("Error: $e");
    return RegistrationResult.failure;
  }
}

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
  // Create a global key that uniquely identifies the Form widget 
  // and allows validation of the form

  // Declare TextEditingController as an instance variable
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // This is a GlobalKey<FormState> NOT GlobalKey<RegisterFormState>
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above
    return Scaffold(
      body: Container(
      key: _formKey,
      child: Column(
        children : <Widget>[
          //Add TextFormFields and ElevatedButton here
          // TextFormFields for email, password, and name
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            controller: _passwordController,
            validator: (value){
              if(value !=null && value.length <8){
                return 'Password length must be at least 8 characters';
              }
              else if(value !=null && value.isEmpty){
                return 'Please enter your Password';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Confirm Password'),
            obscureText: true,
            controller: _confirmPasswordController,
            validator: (value){
              if(value!= null && value.isEmpty){
                return 'Please re-type your password to confirm';
              }else if(value != _confirmPasswordController.text){
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed:() async {
              if(_formKey.currentState?.validate() ?? false){
                //If the form is valid, handle registration logic here
                
                // Call registration function here
              }
      
            },
            child: const Text('Register'),
          ),
        ]
      )
    ),
    );
  }
}
