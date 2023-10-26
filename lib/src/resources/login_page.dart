import 'package:flutter/material.dart';
// import 'package:my_flutter_app/register/register.dart';r
import 'package:my_flutter_app/src/resources/home_page.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:my_flutter_app/src/resources/sign_in.dart';
import 'package:my_flutter_app/register/register.dart';

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   scopes: <String>[
//     'email'
//     'https://www.googleapis.com/auth/contacts.readonly'
//   ]
// );
@immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _showPass = false;
  // TextEditingController _emailController = new TextEditingController();
  // TextEditingController _passController = new TextEditingController();
  // var _emailErr = "Invalid email";
  // var _passErr = "Password must be over 6 characters";
  // var _emailInvalid = false;
  // var _passInvalid = false;
  final _emailController =  TextEditingController();
  final _passController =  TextEditingController();
  final _emailErr = "Invalid email";
  final _passErr = "Password must be over 8 characters";
  var _emailInvalid = false;
  var _passInvalid = false;
  //  GoogleSignInAccount? _currentUser;
 
//   final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();

// late String name;
// late String email;
// late String imageUrl;

// Future<String?> signInWithGoogle() async {
//   // await Firebase.initializeApp();

//   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//   final GoogleSignInAuthentication? googleSignInAuthentication =
//       await googleSignInAccount?.authentication;

//   final AuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleSignInAuthentication?.accessToken,
//     idToken: googleSignInAuthentication?.idToken,
//   );

//   final UserCredential authResult =
//       await _auth.signInWithCredential(credential);
//   final User? user = authResult.user;

//   if (user != null) {
//     // Checking if email and name is null
//     assert(user.email != null);
//     assert(user.displayName != null);
//     assert(user.photoURL != null);

//     name = user.displayName!;
//     email = user.email!;
//     imageUrl = user.photoURL!;

//     // Only taking the first part of the name, i.e., First Name
//     if (name.contains(" ")) {
//       name = name.substring(0, name.indexOf(" "));
//     }

//     assert(!user.isAnonymous);
//     assert(await user.getIdToken() != null);

//     final User? currentUser = _auth.currentUser;
//     assert(user.uid == currentUser?.uid);

//     print('signInWithGoogle succeeded: $user');

//     return '$user';
//   }

//   return null;
// }

// Future<void> signOutGoogle() async {
//   await googleSignIn.signOut();

//   print("User Signed Out");
// }

   @override
  Widget build(BuildContext context) {
    // GoogleSignInAccount? user = _currentUser;
    // if(user!=null){
    //   return Column(
    //     children: [
    //       SizedBox(height: 90,),
    //       GoogleUserCircleAvatar(identity: user),
    //       SizedBox(height: 40,),
    //       ElevatedButton(onPressed: handleSignOut, child: Text('Sign Out')),


    //     ],
    //   );
    // }
    // else{
    return  Scaffold(
        body: Container(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: const BoxConstraints.expand(),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffd8d8d8),
                  ),
                  child: const FlutterLogo()),
              ),
              const Padding(
                  padding:  EdgeInsets.fromLTRB(0, 0, 0, 60),
                  child: Text("Hello\nWelcome Back", style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: Colors.black, 
                    fontSize: 30,
                  ),
                  ),
                
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: TextField(
                    controller: _emailController,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                    labelText: 'Enter your email',
                    errorText: _emailInvalid ? _emailErr : null,
                    labelStyle: 
                    const TextStyle(color: Color(0xff888888), fontSize: 15)
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                       TextField(
                        controller: _passController,
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                        obscureText: !_showPass,
                        decoration: InputDecoration(
                        labelText: 'Enter your password',
                        errorText: _passInvalid ? _passErr : null,
                        labelStyle: 
                        const TextStyle(color: Color(0xff888888), fontSize: 15)
                        ),
                      ),
                  GestureDetector(
                    onTap: onToggleShowPass,
                    child: Text(_showPass ? "HIDE" : "SHOW", 
                    style: const TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    child: const Text('SIGN IN'),
                    style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    backgroundColor: Colors.blue,
                     textStyle: const TextStyle(
                    color: Colors.white,
                     fontSize: 15, 
                     fontStyle: FontStyle.normal),
                     ),
                      onPressed: onSignInClicked,
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                       Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Image.asset('assets/google.png', height: 20, width: 20,),
                     ),

                    const Text('GOOGLE SIGN IN'),
                    ],
                    ),
                    
                    style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    backgroundColor: Colors.blue,
                     textStyle: const TextStyle(
                    color: Colors.white,
                     fontSize: 15, 
                     fontStyle: FontStyle.normal),
                     ),
   onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const HomePage();
                },
              ),
            );
          }
        });
      },                  ),
                ),
              ),

              // Container(
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:(context) => const RegisterForm())
                            );
                        }, 
                        child: const Text('Sign up'),)
                    ],
                    // children: <Widget>[
                      
                    //   Text(
                    //     "NEW USER? SIGN UP",
                    //     style: TextStyle(
                    //     fontSize: 15, color: Color(0xff888888),
                    //   ),
                    //   ),
                    //   Text(
                    //     "FORGOT PASSWORD?",
                    //     style: TextStyle(
                    //       fontSize: 15, color: Colors.blue,
                    //     ),

                    //   ),
                    // ],
                  ),
                ),
                
            ],
          ),
        ),

      );
    
  }

  
void onToggleShowPass () {
setState(() {
  _showPass = !_showPass;
});
}

void onSignInClicked(){
  setState(() {
    if(_emailController.text.length < 6 || !_emailController.text.contains("@")){
      _emailInvalid = true;
    }
    else {
      _emailInvalid = false;
    }

    if(_passController.text.length < 6 ){
      _passInvalid = true;
    }
    else {
      _passInvalid = false;
    }

    if(!_emailInvalid && !_passInvalid){
   Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
  });
}
}