import 'package:flutter/material.dart';

var url = 'http://192.168.35.1:5000/predict';

class settingPage extends StatefulWidget {
  // const MyWidget({super.key});

  @override
  State<settingPage> createState() => _MysettingPageState();
}

class _MysettingPageState extends State<settingPage> {
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 0, 10),
              child: Text(
                'Type your URL here: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
              child: Column(
                children: [
                  TextField(
                    controller: urlController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 5),
                  const Text(
                    'Enter or modify the existing URL and click "Change" to update.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Check if the text field is not empty
                  if (urlController.text.isNotEmpty) {
                    setState(() {
                      // Update the url variable
                      url = urlController.text;
                    });
                  }
                },
                child: Text('Change'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 0, 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const TextSpan(
                      text: 'The existing URL: \n',
                      style: TextStyle(
                        color: Colors.black, 
                      ),
                    ),
                    TextSpan(
                      text: url,
                      style: const TextStyle(
                        color: Colors.red, 
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
