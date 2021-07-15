import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:machine_learning/utils/helpers.dart';

class TextRecognitionPage extends StatefulWidget {
  final CameraDescription camera;
  final String title;
  const TextRecognitionPage({
    Key? key,
    required this.camera,
    required this.title,
  }) : super(key: key);

  @override
  _TextRecognitionPageState createState() => _TextRecognitionPageState();
}

class _TextRecognitionPageState extends State<TextRecognitionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Helpers.showCameraOptionsDialog(
            context: context,
            // camera: _getImageFromCamera,
            // gallery: _getImageFromGallery,
            // live: _getLiveCamera,
          );
        },
        child: Icon(Icons.camera_alt),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
