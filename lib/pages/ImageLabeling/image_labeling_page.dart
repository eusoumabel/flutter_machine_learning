import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:machine_learning/utils/helpers.dart';

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
  File? _image;
  late ImageLabeler imageLabeler;
  List<String> result = [];

  @override
  void initState() {
    super.initState();
    imageLabeler = GoogleMlKit.vision.imageLabeler();
  }

  @override
  void dispose() {
    super.dispose();
    imageLabeler.close();
  }

  _getImageFromCamera() async {
    setState(() {
      _image = Helpers.getImageFromCamera(
        image: _image,
      );
    });
    doImageLabeling();
  }

  _getImageFromGallery() async {
    setState(() {
      _image = Helpers.getImageFromGallery(
        image: _image,
      );
    });
    doImageLabeling();
  }

  doImageLabeling() async {
    final inputImage = InputImage.fromFile(_image!);
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    result.clear();
    for (ImageLabel label in labels) {
      final String text = label.label;
      final double confidence = label.confidence * 100;

      setState(() {
        result.add("$text - ${confidence.toStringAsFixed(2)}%");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Helpers.showCameraOptionsDialog(
          context: context,
          camera: _getImageFromCamera,
          gallery: _getImageFromGallery,
        ),
        child: Icon(Icons.camera_alt),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
