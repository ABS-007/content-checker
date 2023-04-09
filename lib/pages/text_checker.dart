// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TextChecker extends StatefulWidget {
  const TextChecker({super.key});

  @override
  State<TextChecker> createState() => _TextCheckerState();
}

class _TextCheckerState extends State<TextChecker> {
  final TextEditingController _controller = TextEditingController();

  Future<void> detectText() async {
    var uri = Uri.parse(
        "https://profanity-cleaner-bad-word-filter.p.rapidapi.com/profanity");
    var headers = {
      'content-type': 'application/json',
      'X-RapidAPI-Key': '6c0c776a66msh536572f5dfb2d98p1d0b06jsn8b89eeb288c1'
    };
    var body = json.encode(
        {"text": _controller.text, "maskCharacter": "x", "language": "en"});
    var response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['profanities'].isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("This text contains cuss words.")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("invalid Text. Error status code: ${response.statusCode}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (value) {
                _controller.text = value;
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                detectText();
              },
              child: Text("Check Text"))
        ],
      ),
    );
  }
}
