import 'package:flutter/material.dart';
import 'package:my_flutter_app/home/home_page.dart';
import 'package:my_flutter_app/authentication/register.dart';
import 'forget_password.dart';
import 'auth.dart';

@immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPass = false;

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _emailErr = "Invalid email";
  final _passErr = "Password must be over 8 characters";
  var _emailInvalid = false;
  var _passInvalid = false;
  var _show = false;
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  // text field: username , password
  String email = '';
  String password = '';

  // check email and password are full filled or not
  bool checkEmail = false;
  bool checkPassword = false;
  //error messages
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color of the page

      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // color: Color(0xffd8d8d8),
                  ),
                  child: Image.network(
                    'https://icones.pro/wp-content/uploads/2021/04/icone-robot-android-vert.png',
                  //     width: 100,
                  // height: 100,

                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Text(
                  "CBS Counthing",
                  style: TextStyle(
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
                      labelStyle: const TextStyle(
                          color: Color(0xff888888), fontSize: 15)),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                      checkEmail = true;
                    });
                  },
                ),
              ),

              // Password field
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                          labelStyle: const TextStyle(
                              color: Color(0xff888888), fontSize: 15)),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                          checkPassword = true;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: onToggleShowPass,
                      child: Text(
                        _showPass ? "HIDE" : "SHOW",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 132, 181, 53),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),

              //Forget Password field
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0, // 👈 Add this
                        // primary: Colors.white, Try avoiding this as it is deprecated
                        side: const BorderSide(width: 0, color: Colors.white),
                      ),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 132, 181, 53),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Sign in button
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    child: const Text('SIGN IN'),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      backgroundColor: const Color.fromARGB(255, 132, 181, 53),
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontStyle: FontStyle.normal),
                    ),
                    // onPressed: onSignInClicked,
                    onPressed: () async {
                      //_formKey.currentState! : to make sure that it's not null
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);

                        if (result == null) {
                          setState(() {
                            _show = true;
                            error = 'Cannot sign with those credentials';
                          });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                      }
                    },
                  ),
                ),
              ),

              //This box to show error message
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: SizedBox(
                  height: _show ? 12 : 0,
                  child: Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 12.0),
                  ),
                ),
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
                          child: Image.asset(
                            'assets/google.png',
                            height: 20,
                            width: 20,
                          ),
                        ),
                        const Text('GOOGLE SIGN IN',
                                            style: const TextStyle(color: Color.fromARGB(255, 8, 7, 7),),

                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      backgroundColor: const Color(0xffd8d8d8),
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 8, 7, 7),
                          fontSize: 15,
                          fontStyle: FontStyle.normal),
                    ),
                    onPressed: () {
                      AuthService().signInWithGoogle().then((result) {
                        if (result != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        }
                      });
                    },
                  ),
                ),
              ),

              // Container(
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text(
                      'Don\'t have account?',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterForm()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0, // 👈 Add this
                        // primary: Colors.white, Try avoiding this as it is deprecated
                        side: const BorderSide(width: 0, color: Colors.white),
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 132, 181, 53),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
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

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void onSignInClicked() {
    setState(() {
      if (_emailController.text.length < 6 ||
          !_emailController.text.contains("@")) {
        _emailInvalid = true;
      } else {
        _emailInvalid = false;
      }

      if (_passController.text.length < 6) {
        _passInvalid = true;
      } else {
        _passInvalid = false;
      }

      if (!_emailInvalid && !_passInvalid) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    });
  }
}
