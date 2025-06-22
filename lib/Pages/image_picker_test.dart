import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  XFile? _image;
  final _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null)
              /*Image.file(
                File(_image!.path),
                width: 200,
                height: 200,
              ),*/
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              child: Text('Pick Image from Gallery'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImageFromCamera,
              child: Text('Pick Image from Camera'),
            ),
          ],
        ),
      ),
    );
  }
}