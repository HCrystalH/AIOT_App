import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/resources/home_page.dart';
import 'package:my_flutter_app/authentication/sign_in.dart';
import 'package:my_flutter_app/authentication/register.dart';
import 'auth.dart';

@immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _showPass = false;

  final _emailController =  TextEditingController();
  final _passController =  TextEditingController();
  final _emailErr = "Invalid email";
  final _passErr = "Password must be over 8 characters";
  var _emailInvalid = false;
  var _passInvalid = false;
 
  final _formKey = GlobalKey<FormState>();

    final AuthService _auth = AuthService();

    // text field: username , password
    String email = '';
    String password = '';

    //error messages
    String error ='';

  @override
  Widget build(BuildContext context) {

   
    return  Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: Form(
          key:_formKey,

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
              
              // Email or username field
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: TextFormField(
                    controller: _emailController,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Enter your email',
                      errorText: _emailInvalid ? _emailErr : null,
                      labelStyle: 
                        const TextStyle(color: Color(0xff888888), fontSize: 15)
                    ),
                    onChanged:(value){
                      setState(() => email = value);
                    },
                  ),
              ),
              
              // Password field
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                      TextFormField(
                        controller: _passController,
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                        obscureText: !_showPass,
                        decoration: InputDecoration(
                          labelText: 'Enter your password',
                          errorText: _passInvalid ? _passErr : null,
                          labelStyle: 
                            const TextStyle(color: Color(0xff888888), fontSize: 15)
                        ),
                        onChanged: (value){
                          setState(() => password = value );
                        },
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
              
              //Sign in button
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
                    // onPressed: onSignInClicked,
                    onPressed: () async{
                      //_formKey.currentState! : to make sure that it's not null
                      if(_formKey.currentState!.validate()){
                        dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                
                        if(result == null){
                          setState(() {
                            error = 'Cannot sign with those credentials';
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
              
              //This box to show error message
              const SizedBox(height: 10.0),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 12.0),
              ),

              //Sign in with google account
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