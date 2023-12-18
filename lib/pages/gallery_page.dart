import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'setting_page.dart';
class galleryPage extends StatefulWidget {
  // const MyWidget({super.key});

  @override
  State<galleryPage> createState() => _MygalleryPageState();
}

var countResult = 0;
var top,left,width,height;
class _MygalleryPageState extends State<galleryPage> {
  // This value is to select path of the image
  File? _selectedImage;
  var imageWidth = false;
  var imageHeight = false;
  int _currentIndex = 0;
  String selectedType = 'MODEL5'; // Default value
  int result =0;
  
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
                items: <String>['MODEL5', 'MODEL6']
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
                              countObject(_selectedImage,selectedType);

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
                            child: Text(
                              
                              "Number of objects counted: $countResult",
                              style: const TextStyle(
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
      countResult = 0;
    });
  }
  
// Function to count
Future<void> countObject(File? imagefile, String? model) async {
  try {
    // Upload the image to the server
    final response = await http.post(
      Uri.parse(url), // url
      headers: {
        'Connection': 'Keep-Alive',
        'timeout': 'Duration(seconds: 5000)',
      },
      body: {  
        'image': Base64Encoder().convert(await imagefile!.readAsBytes()),
        /* if want to use other models, add more button "MODEL5" "MODEL6"
           use function and return or use global var
        */
        'model': model,
      },
    ).timeout(Duration(seconds: 5000));
    
    debugPrint(response.statusCode.toString());
   
    if (response.statusCode == 200) {
      // Get the count of detected object from the server's response
      final results = jsonDecode(response.body);    
      final result = results[0];
      final count = result['predictions'].length;
      // to draw
      final box = result['predictions'][0]['box'];
      debugPrint(count.toString());
      // debugPrint(box.toString());

      // debugPrint(result.toString());
      // debugPrint(countData.toString());
      // return results;
      setState(() {
        countResult = count;
      });
    } else {
      throw Exception('Error uploading image to server');
    }
  } catch (Error) {
    print('Error counting objects: ${Error.toString()}');
  }
}

}


class CustomPainter{} 
class BoundingBoxPainter extends CustomPainter {

  final double top;
  final double left;
  final double width;
  final double height;

  BoundingBoxPainter(this.top, this.left, this.width, this.height);

  @override
  void draw(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red // Adjust color
      ..strokeWidth = 2.0; // Adjust line width

    final topY = top * size.height; // Convert relative top to absolute pixel position
    final leftX = left * size.width; // Convert relative left to absolute pixel position
    final bottomY = topY + height * size.height; // Calculate bottom Y based on height

    // Draw two vertical lines for the bounding box
    canvas.drawLine(Offset(leftX, topY), Offset(leftX, bottomY), paint);
    canvas.drawLine(Offset(leftX + width * size.width, topY), Offset(leftX + width * size.width, bottomY), paint);
  }
}