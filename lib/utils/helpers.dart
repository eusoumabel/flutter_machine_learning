import 'package:flutter/material.dart';

class Helpers {
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
          "Do you want to choose a picture from your gallery, take one or use the live camera?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              live!();
            },
            child: Text(
              "Live",
              style: TextStyle(color: Colors.blue[900]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              camera!();
            },
            child: Text(
              "Camera",
              style: TextStyle(color: Colors.blue[900]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              gallery!();
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
