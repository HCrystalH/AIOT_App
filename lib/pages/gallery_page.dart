import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'setting_page.dart';
import 'package:flutter/cupertino.dart';

class galleryPage extends StatefulWidget {
  // const MyWidget({super.key});

  @override
  State<galleryPage> createState() => _MygalleryPageState();
}

class globalvar {
  var countResult;
}

var countResult = 0;
var counterWithConfidence =
    0; // for display # object counted with a specific confidence
var resultTodraw;
var WidthImage;
var HeightImage;
double _currentConfidence = 0;

class _MygalleryPageState extends State<galleryPage> {
  // This value is to select path of the image
  File? _selectedImage;
  var imageWidth = false;
  var imageHeight = false;

  var flag = false;
  int _currentIndex = 0;
  String selectedType = 'MODEL5'; // Default value
  int result = 0;

  int ivisible = 1;
  double temp = 0;
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
                child: Stack(children: [
                  SizedBox(
                      width: imageWidth ? double.infinity : 0,
                      height: imageWidth ? 300 : 0,
                      child: _selectedImage != null
                          ? Image.file(
                              _selectedImage!,
                              fit: BoxFit
                                  .contain, // Choose appropriate fit based on your preference
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Ensures full width coverage
                            )
                          : const Center(
                              child: Text(
                                "Please selected an image",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12.0),
                              ),
                            )),
                  SizedBox(
                    width: flag ? double.infinity : 0,
                    height: flag ? 300 : 0,
                    child: ListView(children: <Widget>[
                      Container(
                        width: 640,
                        height: 300,
                        child: CustomPaint(
                          painter: OpenPainter(),
                        ),
                      ),
                    ]),
                  ),
                ])),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      child: Visibility(
                          visible: ivisible == 1,
                          child: MaterialButton(
                            color: Color.fromARGB(255, 235, 131, 71),
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
                            color: Color.fromARGB(255, 241, 144, 80),
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
                            color: Color.fromARGB(255, 121, 180, 137),
                            child: const Text(
                              "Count",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              countObject(_selectedImage, selectedType);
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
                            color: Color.fromARGB(255, 102, 214, 237),
                            child: Text(
                              "Number of objects counted: $countResult",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 33, 23, 23),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              setState(() {
                                countResult = counterWithConfidence;
                              });
                            },
                          ))),
                ])),
            Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                child: Visibility(
                visible: ivisible == 0,
                child: Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _currentConfidence,
                        max: 1,
                        divisions: 10,
                        label: _currentConfidence.toString(),
                        onChanged: (double value) async {
                          setState(() {
                            _currentConfidence = value;
                            countResult = counterWithConfidence;
                          });
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: someAsyncOperation,
                      child: const Text(
                        'Refresh',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )))
          ]),
    ));
  }

  Future<void> someAsyncOperation() async {
    setState(() {
      countResult = counterWithConfidence;
      _currentConfidence = _currentConfidence;
    });
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
    var decodedImage =
        await decodeImageFromList(_selectedImage!.readAsBytesSync());
    WidthImage = decodedImage.width / 2;
    HeightImage = decodedImage.height / 2;
  }

  // Function to remove Image
  void removeImage() {
    setState(() {
      ivisible = 1;
      imageHeight = false;
      imageWidth = false;
      _selectedImage = null;
      countResult = 0;

      flag = false;
    });
  }

// Function to count
  Future<void> countObject(File? imagefile, String? model) async {
    // debugPrint(WidthImage.toString());
    // debugPrint(HeightImage.toString());
    final response = await http.post(
      Uri.parse(url), // url
      headers: {
        'Connection': 'Keep-Alive',
        'Timeout': 'Duration(seconds: 5000)',
      },
      body: {
        'image': Base64Encoder().convert(await imagefile!.readAsBytes()),
        /* if want to use other models, add more button "MODEL5" "MODEL6"
          use function and return or use global var
      */
        'model': model,
      },
    ).timeout(Duration(seconds: 5000));
    try {
      // Upload the image to the server

      debugPrint(response.statusCode.toString());
      debugPrint(response.contentLength.toString());

      if (response.statusCode == 200) {
        // Get the count of detected object from the server's response
        dynamic results = jsonDecode(response.body);
        /*
        response.body khoan đưa vào jsonDecode() => đưa vào class ? có ?method  => Why? buffer size ? 
        aysnchronous way ? nhận nhiều lần
      */
        dynamic result = results[0];
        dynamic count = result['predictions'].length;
        // to draw
        dynamic box = result['predictions'][0]['box'];
        debugPrint(count.toString());
        // debugPrint(box.toString());

        resultTodraw = result; // to draw bounding box

        // debugPrint(result.toString());
        // debugPrint(countData.toString());
        // return results;
        setState(() {
          countResult = count;
          // _selectedImage = File(_selectedImage!.path);
          flag = true;
        });
      } else {
        throw Exception('Error uploading image to server');
      }
    } catch (Error) {
      print('Error counting objects: ${Error.toString()}');
    }
  }
}

class OpenPainter extends CustomPainter {
  // OpenPainter(this.x1, this.x2,this.y1, this.y2);

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.lightGreen // Adjust color
      ..strokeWidth = 2.0; // Adjust line width

    var len = resultTodraw['predictions'].length;

    counterWithConfidence = 0;
    if (resultTodraw['predictions'][0]['segment'] == null) {
      debugPrint('BOUNDING BOX');
      for (int i = 0; i < len; i++) {
        var box = resultTodraw['predictions'][i]['box'];
        var prediction = resultTodraw['predictions'][i];
        var confidence = prediction['confidence'];

        // Display images which confidence >= selected conf
        if (confidence < _currentConfidence) continue;

        final x1 = box['x1'] * (size.width);
        final x2 = box['x2'] * (size.width);

        final y1 = box['y1'] * (size.height);
        final y2 = box['y2'] * (size.height);
        // Draw two vertical lines for the bounding box
        canvas.drawLine(Offset(x1, y1), Offset(x2, y1), paint1);
        canvas.drawLine(Offset(x2, y1), Offset(x2, y2), paint1);
        canvas.drawLine(Offset(x2, y2), Offset(x1, y2), paint1);
        canvas.drawLine(Offset(x1, y2), Offset(x1, y1), paint1);

        final number = (i + 1).toString(); // Convert index to string
        TextSpan span = TextSpan(
            style: const TextStyle(
                color: Color.fromRGBO(21, 239, 235, 0.885),
                fontSize: 10,
                fontWeight: FontWeight.bold),
            text: number);
        TextPainter tp = TextPainter(
            text: span,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr);
        tp.layout();

        // Calculate text position (e.g., top-left corner of the box)
        final textX = (x1 + x2) / 2 + (x1 + x2) % 2; // Adjust horizontal offset
        final textY = (y1 + y2) / 2 + (y1 + y2) % 2; // Adjust vertical offset

        tp.paint(canvas, Offset(textX, textY));
        counterWithConfidence++;
        countResult = counterWithConfidence;
      }
    } else {
      debugPrint('SEGMENT');

      for (int i = 0; i < len; i++) {
        var segment = resultTodraw['predictions'][i]['segment'];
        // segment = [[x,y], [x,y], ...]
        var prediction = resultTodraw['predictions'][i];
        var confidence = prediction['confidence'];

        if (confidence < _currentConfidence) continue;
        for (int j = 0; j < segment.length - 1; j++) {
          final currentX = segment[j][0] * (size.width);
          final currentY = segment[j][1] * (size.height);

          final nextX = segment[j + 1][0] * (size.width);
          final nextY = segment[j + 1][1] * (size.height);

          canvas.drawLine(
              Offset(currentX, currentY), Offset(nextX, nextY), paint1);
        }

        final x0 = segment[0][0] * (size.width);
        final y0 = segment[0][1] * (size.height);

        final xn = segment[segment.length - 1][0] * (size.width);
        final yn = segment[segment.length - 1][1] * (size.height);
        canvas.drawLine(Offset(x0, y0), Offset(xn, yn), paint1);

        final number = (i + 1).toString(); // Convert index to string
        TextSpan span = TextSpan(
            style: const TextStyle(
                color: Color.fromARGB(255, 238, 15, 186), fontSize: 6),
            text: number);
        TextPainter tp = TextPainter(
            text: span,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr);
        tp.layout();

        // Calculate text position (e.g., top-left corner of the box)
        final textX = (x0); // Adjust horizontal offset
        final textY = (y0) + i; // Adjust vertical offset

        tp.paint(canvas, Offset(textX, textY));

        counterWithConfidence++;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
