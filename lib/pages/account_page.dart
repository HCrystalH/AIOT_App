import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/authentication/login_page.dart';

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
  //This function is to choose image from gallery
  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
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
                            backgroundColor: Colors.transparent, // Set a transparent background

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
    ],
  ),
);
  }
}
