import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:machine_learning/utils/helpers.dart';

class FaceDetectionPage extends StatefulWidget {
  final CameraDescription camera;
  final String title;
  const FaceDetectionPage({
    Key? key,
    required this.camera,
    required this.title,
  }) : super(key: key);

  @override
  _FaceDetectionPageState createState() => _FaceDetectionPageState();
}

class _FaceDetectionPageState extends State<FaceDetectionPage> {
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
