//import 'dart:html';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/authentication/auth.dart';
import 'package:my_flutter_app/authentication/login_page.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:my_flutter_app/authentication/sign_in.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _MyHomeState();
}

class _MyHomeState extends State<HomePage> {
  // This value is to select path of the image
  File? _selectedImage;
  var imageWidth = false;
  var imageHeight = false;
  int _currentIndex = 2;

  int _accountColor = Colors.grey.value;
  int _cameraColor = Colors.grey.value;
  int _settingsColor = Colors.grey.value;
  int _galleryColor = Colors.grey.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      // Add your sign-out logic here
                      //  _signOut();
                    },
                  ),
                  const Text(
                    'Log Out',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Display image
                Padding(
                  padding: EdgeInsets.fromLTRB(imageWidth ? 0 : 140, 0, 0, 20),
                  child: SizedBox(
                    width: imageWidth ? double.infinity : 0,
                    height: imageHeight ? 300 : 0,
                    child: _selectedImage != null
                        ? Image.file(_selectedImage!)
                        : const Text(
                            "Please selected an image",
                            style: TextStyle(color: Colors.red, fontSize: 12.0),
                          ),
                  ),
                ),
                // //COUNT BUTTON
                // Padding(
                // padding: const EdgeInsets.fromLTRB(100, 0, 0, 20),

                // child: MaterialButton(
                //   color: Colors.blue,
                //   child: const Text(
                //     "Count",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16
                //     ),
                //   ),
                //   onPressed: () {
                //     countObject(_selectedImage);
                //   },
                // )
                // ),
                // Button pick image from gallery
                // Padding(
                //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment
                //           .start, // Adjust the alignment as needed
                //       children: [
                //         Expanded(
                //             child: MaterialButton(
                //           color: Colors.blue,
                //           child: const Text(
                //             "Gallery",
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 16,
                //             ),
                //           ),
                //           onPressed: () {
                //             _pickImageFromGallery();
                //           },
                //         )),
                //         Expanded(
                //             child: MaterialButton(
                //           color: Colors.red,
                //           child: const Text(
                //             "Camera",
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 16,
                //             ),
                //           ),
                //           onPressed: () {
                //             // Add your camera logic here
                //           },
                //         )),
                //       ],
                //     )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: MaterialButton(
                            color: Colors.red,
                            child: const Text(
                              "Remove",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              removeImage();
                            },
                          )),
                          Expanded(
                              child: MaterialButton(
                            color: Colors.blue,
                            child: const Text(
                              "Count",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              countObject(_selectedImage);
                            },
                          ))
                        ])),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                //   child: SizedBox(
                //     width: double.infinity,
                //     height: 56,
                //     child: ElevatedButton(
                //         child: const Text('SIGN OUT'),
                //         style: ElevatedButton.styleFrom(
                //           shape: const RoundedRectangleBorder(
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(8))),
                //           backgroundColor: Colors.blue,
                //           textStyle: const TextStyle(
                //               color: Colors.white,
                //               fontSize: 15,
                //               fontStyle: FontStyle.normal),
                //         ),
                //         onPressed: () {
                //           AuthService().signOutGoogle();
                //           Navigator.of(context).pushAndRemoveUntil(
                //               MaterialPageRoute(builder: (context) {
                //             return const LoginPage();
                //           }), ModalRoute.withName('/'));
                //         }),
                //   ),
                // ),
                BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle,
                          color: Color(_accountColor)),
                      label: 'Account',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings, color: Color(_settingsColor)),
                      label: 'Settings',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/camera.png',
                          width: 24.0,
                          height: 24.0,
                          color: Color(_cameraColor)),
                      label: 'Camera',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.photo_library,
                          color: Color(_galleryColor)),
                      label: 'Gallery',
                    ),
                  ],
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      // Reset all colors to grey
                      _accountColor = Colors.grey.value;
                      _cameraColor = Colors.grey.value;
                      _settingsColor = Colors.grey.value;
                      _galleryColor = Colors.grey.value;

                      // Set the selected icon color to blue
                      switch (index) {
                        case 0:
                          _currentIndex = 0;
                          _accountColor = Colors.blue.value;
                          break;
                        case 2:
                          _currentIndex = 2;
                          _cameraColor = Colors.blue.value;
                          break;
                        case 1:
                          _currentIndex = 1;
                          _settingsColor = Colors.blue.value;
                          break;
                        case 3:
                          _pickImageFromGallery();
                          _currentIndex = 3;
                          _galleryColor = Colors.blue.value;
                          break;
                      }
                    });

                    // Handle navigation or any other action based on the selected index
                    print('Tapped on item $index');
                  },
                ),
              ]),
        ));
  }

  // Function to select image from library
  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageHeight = true;
      imageWidth = true;
      _selectedImage = File(returnedImage!.path);
    });
  }

  //
  void removeImage() {
    setState(() {
      imageHeight = false;
      imageWidth = false;
      _selectedImage = null;
    });
  }
}

// Function to count
Future<void> countObject(File? imagefile) async {
  try {
    // Upload the image to the server
    final response = await http.post(Uri.parse(''), // url
        body: {
          'image': Base64Encoder().convert(await imagefile!.readAsBytes()),
        });
    if (response.statusCode == 200) {
      // Get the count of detected object from the server's response
      final countData = jsonDecode(response.body);
      final count = countData['count'];

      return count;
    } else {
      throw Exception('Error uploading image to server');
    }
  } catch (Error) {
    print('Error counting objects: ${Error.toString()}');
  }
}
