// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageChecker extends StatefulWidget {
  const ImageChecker({super.key});

  @override
  State<ImageChecker> createState() => _ImageCheckerState();
}

class _ImageCheckerState extends State<ImageChecker> {
  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final temporaryimage = File(image.path);
    setState(() {
      _image = temporaryimage;
    });
  }

  Future<void> detectImage(File imageFile) async {
    final url = Uri.parse(
        "https://nsfw-images-detection-and-classification.p.rapidapi.com/adult-content-file");
    final request = http.MultipartRequest('POST', url)
      ..headers.addAll({
        'X-RapidAPI-Key': '633442de3cmsh842cfc4c45c4673p1badacjsn7ebcc68aa8c7',
        'X-RapidAPI-Host':
            'nsfw-images-detection-and-classification.p.rapidapi.com',
      })
      ..files.add(await http.MultipartFile.fromPath("image", imageFile.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      final jsonResponse = json.decode(body);
      final bool isUnsafe = jsonResponse["unsafe"];
      if (isUnsafe == true) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("This image features 18+ content")));
          }
       else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Approved")));
      }
    } else {
      debugPrint("Request failed with status: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Checker")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: InkWell(
                onTap: () {
                  getImage();
                },
                child: _image == null
                    ? Image(image: AssetImage("assets/images.png"))
                    : Image.file(File(_image!.path))),
          ),
          ElevatedButton(
              onPressed: () async {
                detectImage(File(_image!.path));
              },
              child: Text("Check Image"))
        ],
      ),
    );
  }
}
