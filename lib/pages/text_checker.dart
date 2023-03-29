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
    final url = Uri.parse(
        "https://neutrinoapi-bad-word-filter.p.rapidapi.com/bad-word-filter");
    final headers = {
      'content-type': 'application/json',
      'X-RapidAPI-Key': '6c0c776a66msh536572f5dfb2d98p1d0b06jsn8b89eeb288c1',
      'X-RapidAPI-Host': 'neutrinoapi-bad-word-filter.p.rapidapi.com'
    };
    final body = json.encode({"content": _controller.text});
    final response = await http.post(url, headers: headers, body: body);
    debugPrint(response.body);
    if (response.statusCode == 200) {
      final jsonresponse = jsonDecode(response.body);
      final bool iscussed = jsonresponse["is-bad"];
      if (iscussed == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("This text contains cuss word")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Approved")));
      }
    } else {
      debugPrint("Request failed with status: ${response.statusCode}");
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
