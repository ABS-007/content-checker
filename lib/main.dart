import 'package:content_checker/pages/homepage.dart';
import 'package:content_checker/pages/image_checker.dart';
import 'package:content_checker/pages/text_checker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        "image": (context) => ImageChecker(),
        "text": (context) => TextChecker(),
      },
    );
  }
}
