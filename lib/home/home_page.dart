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
  File ? _selectedImage;
  var imageWidth = false;
  var imageHeight = false;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(title: const Text("Home Page"),
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
                  width: imageWidth ? double.infinity : 100,
                  height: imageHeight ? 300 : 0,
                  child: _selectedImage!=null ? Image.file(_selectedImage!): const Text("Please selected an image",
                  style: TextStyle(color: Colors.red, fontSize: 12.0),

                  ),
                ),
              ),
              //COUNT BUTTON
              Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 0, 20),

              child: MaterialButton(
                color: Colors.blue,
                child: const Text(
                  "Count",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                onPressed: () {
                  countObject(_selectedImage);
                },
              )
              ),
              // Button pick image from gallery
              Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 0, 20),

              child: MaterialButton(
                color: Colors.blue,
                child: const Text(
                  "Pick image from Gallery",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                onPressed: () {
                  _pickImageFromGallery();
                },
              )
              ),
              Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 0, 20),

              child: MaterialButton(
                color: Colors.red,
                child: const Text(
                  "Pick image from Camera",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                onPressed: () {},
              )
              ),
 
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    child: const Text('SIGN OUT'),
                    style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    backgroundColor: Colors.blue,
                     textStyle: const TextStyle(
                    color: Colors.white,
                     fontSize: 15, 
                     fontStyle: FontStyle.normal),
                     ),
                      onPressed:(){ 
                        AuthService().signOutGoogle();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                          builder: (context) {return const LoginPage();}),
                        ModalRoute.withName('/'));


                      }
                  ),
                ),
              ),

 
                
            ]
        ),
      )
      
    );
  }
  // Function to select image from library
   Future _pickImageFromGallery() async{
      final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
     setState(() {
    imageHeight = true;
    imageWidth = true;
    _selectedImage = File(returnedImage!.path);
    });
   }
  }

  // Function to count
  Future<void> countObject(File ? imagefile) async{
      try{
        // Upload the image to the server
        final response = await http.post(
          Uri.parse(''),  // url 
          body:{
            'image':Base64Encoder().convert(await imagefile!.readAsBytes()),
          }
        );
        if(response.statusCode == 200){
          // Get the count of detected object from the server's response
          final countData = jsonDecode(response.body);
          final count = countData['count'];

          return count;
        }else {throw Exception('Error uploading image to server');}
      }catch(Error){
        print('Error counting objects: ${Error.toString()}');
        
      }
  }
  

