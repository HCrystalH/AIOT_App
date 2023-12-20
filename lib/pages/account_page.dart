import 'dart:io';
import 'dart:typed_data';
import 'package:my_flutter_app/authentication/login_page.dart';
import 'package:my_flutter_app/authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/authentication/login_page.dart';
import 'package:my_flutter_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

Uint8List? _image;
// This is the support function for choosing image with the type of _image is Unit8List
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Images Selected');
}

class accountPage extends StatefulWidget {
  @override
  State<accountPage> createState() => _MyaccountPageState();
}

class _MyaccountPageState extends State<accountPage> {
  String _currentPassword = '';
  String _newPassword = '';
  String _cfirmNewPassword = '';
  String message = '';
  bool checkPassword = false;
  bool _show = false;
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  //This function is to choose image from gallery
  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

// This function is to show the modal change password
  void _showChangePasswordModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.maxFinite, // Set width to maximum
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white, // Set background color
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Current Password'),
                    validator: (value) =>
                        checkPassword ? 'Incorrect Password !!!' : null,
                    onChanged: (value) {
                      setState(() {
                        _currentPassword = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'New Password'),
                    validator: (value) => _newPassword.length > 8
                        ? 'Password length must be greater than 8 characters'
                        : null,
                    onChanged: (value) {
                      setState(() {
                        _newPassword = value;
                        _cfirmNewPassword = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Confirm New Password'),
                    validator: (value) {
                      if (value == null)
                        return 'Password does not match!';
                      else if (value != _cfirmNewPassword)
                        return 'Password does not match!';
                      else
                        return null;
                    },
                  ),

                  // CHANGE PASSWORD BUTTON
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, // Set text color
                    ),
                    child: const Text(
                      'Change Password',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();

                        if (_cfirmNewPassword != _newPassword) {
                          setState(() =>
                              message = 'Please enter information correctly!');
                        } else {
                          setState(
                              () => message = 'Successful Change Password!');
                          await DatabaseService(uid: _uid)
                              .updateUserData(email, _cfirmNewPassword);
                          Navigator.of(context).pop(); // Close the modal
                        }
                      } else {
                        setState(() => message =
                            'Please enter full fields and correct information!');
                      }
                    },
                  ),

                  // This box to show error message
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      height: _show ? 12 : 0,
                      child: Text(
                        message,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Center(
              child: Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/9131/9131529.png'),
                          backgroundColor: Colors
                              .transparent, // Set a transparent background
                        ),
                  Positioned(
                    bottom: -15,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            email,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          ElevatedButton(
            child: const Text(
              'Change Password',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _showChangePasswordModal();
              Future<bool> CheckPassword(String _password) async {
                dynamic result =
                    await _auth.signInWithEmailAndPassword(email, _password);
                if (result != null)
                  checkPassword = true;
                else
                  checkPassword = false;

                return false;
              }
            },
          ),
        ],
      ),
    );
  }
}
