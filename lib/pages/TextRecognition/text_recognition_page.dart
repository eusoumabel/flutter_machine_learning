import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
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
  late Future<File> imageFile;
  late ImagePicker imagePicker;
  late TextDetector textDetector;
  File? _image;
  String result = '';

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    textDetector = GoogleMlKit.vision.textDetector();
  }

  @override
  void dispose() {
    super.dispose();
    textDetector.close();
  }

  _getImageFromCamera() async {
    PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.camera);
    File image = File(pickedFile!.path);
    setState(() {
      _image = image;
      if (_image != null) {
        doTextRecognition(inputImage: InputImage.fromFile(_image!));
      }
    });
  }

  _getImageFromGallery() async {
    PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    File image = File(pickedFile!.path);
    setState(() {
      _image = image;
      if (_image != null) {
        doTextRecognition(inputImage: InputImage.fromFile(_image!));
      }
    });
  }

  doTextRecognition({required InputImage inputImage}) async {
    result = '';
    final _inputImage = inputImage;

    final RecognisedText recognisedText =
        await textDetector.processImage(_inputImage);

    String text = recognisedText.text;
    setState(() {
      result = text;
    });
  }

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
            camera: _getImageFromCamera,
            gallery: _getImageFromGallery,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _image != null
                      ? Image.file(
                          _image!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.camera_alt,
                          color: Colors.grey[500],
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ListTile(
                    title: SelectableText(
                      result,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
