import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Helpers {
  static getImageFromCamera({File? image}) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? pickedFile = await imagePicker.getImage(
      source: ImageSource.camera,
    );

    image = pickedFile != null ? File(pickedFile.path) : image;
    return image;
  }

  static getImageFromGallery({File? image}) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? pickedFile = await imagePicker.getImage(
      source: ImageSource.camera,
    );

    image = pickedFile != null ? File(pickedFile.path) : image;
    return image;
  }

  static showCameraOptionsDialog({
    required BuildContext context,
    Function? camera,
    Function? gallery,
    Function? live,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Choose how to capture the image!",
        ),
        content: Text(
          "Do you want to choose a picture from your gallery, take one or live camera?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              live!;
            },
            child: Text(
              "Live",
              style: TextStyle(color: Colors.blue[900]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              camera!;
            },
            child: Text(
              "Camera",
              style: TextStyle(color: Colors.blue[900]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              gallery!;
            },
            child: Text(
              "Gallery",
              style: TextStyle(color: Colors.blue[900]),
            ),
          ),
        ],
      ),
    );
  }
}
