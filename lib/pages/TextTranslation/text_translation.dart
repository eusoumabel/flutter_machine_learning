import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TextTranslationPage extends StatefulWidget {
  final CameraDescription camera;
  final String title;
  const TextTranslationPage({
    Key? key,
    required this.camera,
    required this.title,
  }) : super(key: key);

  @override
  _TextTranslationPageState createState() => _TextTranslationPageState();
}

class _TextTranslationPageState extends State<TextTranslationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
