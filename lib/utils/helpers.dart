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
          "Choose how to capture the image.",
        ),
        content: Text(
          "How do you want to capture the image?",
        ),
        actions: [
          Visibility(
            visible: (live != null),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                live!();
              },
              child: Text(
                "Live",
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ),
          Visibility(
            visible: (camera != null),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                camera!();
              },
              child: Text(
                "Camera",
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ),
          Visibility(
            visible: (gallery != null),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                gallery!();
              },
              child: Text(
                "Gallery",
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
