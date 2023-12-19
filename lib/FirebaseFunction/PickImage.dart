import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage {
  static Future<File?> pickImageFromGallery(BuildContext context) async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text('${e.toString()}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return image;
  }
  
}
