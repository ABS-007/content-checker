import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Content Checker"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 400,
              child: ElevatedButton(
                  onPressed: () {}, child: Text("Image Checker"))),
          SizedBox(height: 20),
          SizedBox(
              width: 400,
              child:
                  ElevatedButton(onPressed: () {}, child: Text("Text Checker")))
        ],
      ),
    );
  }
}
