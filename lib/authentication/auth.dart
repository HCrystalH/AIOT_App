import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/user.dart';
class AuthService{
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /*create user object based on FirebaseUser
  Note: FirebaseUser => User  (2023 version)
  */
  MyUser? _userFromFirebaseUser (User user){
    return MyUser(uid: user.uid); //if user !=null
  }

  // sign in Anonymous 
  Future signInAnon() async {
    try{
      // AuthResult => UserCredential
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      
      if(user != null){
        return _userFromFirebaseUser(user);
      }
      
    } catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  // Sign in with email and password

  // Register with email and password
  Future registerWithEmailAndPassword(String useremail, String userpassword) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: useremail, password: userpassword);
      User? user = result.user;
      
      if(user != null) return _userFromFirebaseUser(user);
      
    }catch(e){

      debugPrint(e.toString());
      return null;
    }
  }

  // Sign out
}