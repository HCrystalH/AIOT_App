import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/authentication/auth.dart';
import 'package:my_flutter_app/authentication/login_page.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:image_picker/image_picker.dart';

class galleryPage extends StatefulWidget {
  // const MyWidget({super.key});

  @override
  State<galleryPage> createState() => _MygalleryPageState();
}

class _MygalleryPageState extends State<galleryPage> {
  // This value is to select path of the image
  File? _selectedImage;
  var imageWidth = false;
  var imageHeight = false;
  int _currentIndex = 0;
  String selectedType = 'TYPE5'; // Default value

  int ivisible = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 0, 10),
              child: Text(
                'Choose Types:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
              child: DropdownButton<String>(
                value: selectedType,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedType = newValue!;
                  });
                },
                items: <String>['TYPE5', 'TYPE6']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            // Display image
            Padding(
              padding: EdgeInsets.fromLTRB(imageWidth ? 0 : 140, 0, 0, 10),
              child: SizedBox(
                  width: imageWidth ? double.infinity : 0,
                  height: imageHeight ? 300 : 0,
                  child: _selectedImage != null
                      ? Image.file(_selectedImage!)
                      : const Center(
                          child: Text(
                            "Please selected an image",
                            style: TextStyle(color: Colors.red, fontSize: 12.0),
                          ),
                        )),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      child: Visibility(
                          visible: ivisible == 1,
                          child: MaterialButton(
                            color: Colors.red,
                            child: const Text(
                              "Upload image",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              _pickImageFromGallery();
                            },
                          ))),
                ])),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      child: Visibility(
                          visible: ivisible == 0,
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
                          ))),
                  Expanded(
                      child: Visibility(
                          visible: ivisible == 0,
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
                          )))
                ])),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      child: Visibility(
                          visible: ivisible == 0,
                          child: MaterialButton(
                            color: Color.fromARGB(255, 232, 241, 67),
                            child: const Text(
                              "Number of objects counted: ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 120, 4, 4),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              // removeImage();
                            },
                          ))),

                ])),
          ]),
    ));
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      ivisible = 0;
      imageHeight = true;
      imageWidth = true;
      _selectedImage = File(returnedImage!.path);
    });
  }

  // Function to remove Image
  void removeImage() {
    setState(() {
      ivisible = 1;
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
    final response =
        await http.post(Uri.parse('http://192.168.35.1:5000/predict'), // url
            body: {
          'image': Base64Encoder().convert(await imagefile!.readAsBytes()),
        });
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      // Get the count of detected object from the server's response
      final countData = jsonDecode(response.body);
      final count = countData.length;
      debugPrint(count.toString());
      // debugPrint(countData.toString());
      return count;
    } else {
      throw Exception('Error uploading image to server');
    }
  } catch (Error) {
    print('Error counting objects: ${Error.toString()}');
  }
}
