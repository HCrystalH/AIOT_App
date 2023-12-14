//import 'dart:html';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/authentication/auth.dart';
import 'package:my_flutter_app/authentication/login_page.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/pages/account_page.dart';
import 'package:my_flutter_app/pages/setting_page.dart';
import 'package:my_flutter_app/pages/camera_page.dart';
import 'package:my_flutter_app/pages/gallery_page.dart';

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
  PageController _pageController = PageController();

  // This value is to select path of the image
  File? _selectedImage;
  var imageWidth = false;
  var imageHeight = false;
  int _currentIndex = 0;
  int ivisible = 1;
  int _accountColor = const Color.fromARGB(255, 132, 181, 53).value;
  int _cameraColor = Colors.grey.value;
  int _settingsColor = Colors.grey.value;
  int _galleryColor = Colors.grey.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: const Text("Home Page"),         
backgroundColor: const Color.fromARGB(255, 132, 181, 53), // Use the RGB value for matcha

  
  actions: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Add your sign-out logic here
          AuthService().signOutGoogle();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            ModalRoute.withName('/'),
          );
        },
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
              },
            ),
            const Text(
              'Log Out',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  ],
),
        body: 
        PageView(
        controller: _pageController,
        children: [
        accountPage(),
        settingPage(),
        cameraPage(),
        galleryPage(),
        // Center(
        //   child: Column(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         // Display image
        //         Padding(
        //           padding: EdgeInsets.fromLTRB(imageWidth ? 0 : 140, 0, 0, 20),
        //           child: SizedBox(
        //             width: imageWidth ? double.infinity : 0,
        //             height: imageHeight ? 300 : 0,
        //             child: _selectedImage != null
        //                 ? Image.file(_selectedImage!)
        //                 : const 
        //                 Center(
        //                 child: Text(
        //                     "Please selected an image",
        //                     style: TextStyle(color: Colors.red, fontSize: 12.0),
        //                   ),
        //                 )
        //           ),
        //         ),
        //         Padding(
        //             padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        //             child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   Expanded(
        //                     child: Visibility(
        //                     visible: ivisible == 0,
        //                     child: MaterialButton(
        //                     color: Colors.red,
        //                     child: const Text(
        //                       "Remove",
        //                       style: TextStyle(
        //                           color: Colors.white,
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: 16),
        //                     ),
        //                     onPressed: () {
        //                       removeImage();
        //                     },
        //                   ))),
        //                   Expanded(
        //                     child:Visibility(
        //                     visible: ivisible == 0,
        //                       child: MaterialButton(
        //                     color: Colors.blue,
        //                     child: const Text(
        //                       "Count",
        //                       style: TextStyle(
        //                           color: Colors.white,
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: 16),
        //                     ),
        //                     onPressed: () {
        //                       countObject(_selectedImage);
        //                     },
        //                   )))
        //                 ])),
                

  
        //       ]),
        // )
        ],
        // onPageChanged: (index) {
        //   setState(() {
        //     _currentIndex = index;
        //   });
        // },        
        ),
       bottomNavigationBar: BottomNavigationBar(
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
                  selectedItemColor:  const Color.fromARGB(255, 132, 181, 53),
                  unselectedItemColor: Colors.grey,
                  currentIndex: _currentIndex,
                  onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
                    setState(() {
                      // Reset all colors to grey
                      _accountColor = Colors.grey.value;
                      _cameraColor = Colors.grey.value;
                      _settingsColor = Colors.grey.value;
                      _galleryColor = Colors.grey.value;
                       Color newColor = const Color.fromARGB(255, 132, 181, 53);


                      // Set the selected icon color to blue
                      switch (index) {
                        case 0:
                          _currentIndex = 0;
                          _accountColor = newColor.value;
                          break;
                        case 1:
                          _currentIndex = 1;
                          _settingsColor = newColor.value;
                          break;
                        case 2:
                          _pickImageFromCamera();
                          _currentIndex = 2;
                          _cameraColor = newColor.value;
                          break;
                        case 3:
                          // _pickImageFromGallery();
                          _currentIndex = 3;
                          _galleryColor = newColor.value;
                          break;
                      }
                    });

                    // Handle navigation or any other action based on the selected index
                    print('Tapped on item $index');
                  },
                ),
        
        );
  }


// Function to pick image from camera
  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      ivisible = 0;
      imageHeight = true;
      imageWidth = true;
      _selectedImage = File(returnedImage!.path);
    });
  }
  

}

