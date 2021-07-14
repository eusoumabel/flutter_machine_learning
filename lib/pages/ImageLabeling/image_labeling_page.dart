import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImageLabelingPage extends StatefulWidget {
  final CameraDescription camera;
  final String title;
  const ImageLabelingPage({
    Key? key,
    required this.camera,
    required this.title,
  }) : super(key: key);

  @override
  _ImageLabelingPageState createState() => _ImageLabelingPageState();
}

class _ImageLabelingPageState extends State<ImageLabelingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
