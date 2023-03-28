import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Content Checker"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
                height: 40,
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "image");
                    },
                    child: Text("Image Checker"))),
          ),
          SizedBox(height: 20),
          Center(
            child: SizedBox(
                height: 40,
                width: 300,
                child: ElevatedButton(
                    onPressed: () {Navigator.pushNamed(context, "text");}, child: Text("Text Checker"))),
          )
        ],
      ),
    );
  }
}
