import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:machine_learning/pages/BarcodeScanner/barcode_scanner_page.dart';
import 'package:machine_learning/pages/FaceDetection/face_detection_page.dart';
import 'package:machine_learning/pages/ImageLabeling/image_labeling_page.dart';

import 'TextRecognition/text_recognition_page.dart';
import 'TextTranslation/text_translation.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const HomePage({Key? key, required this.cameras}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navitateTo(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Machine Learning"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                title: Text('Image Labeling'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: true,
                onTap: () => navitateTo(
                  ImageLabelingPage(
                    cameras: widget.cameras,
                    title: 'Image Labeling',
                  ),
                ),
              ),
              ListTile(
                title: Text('Barcode Scanner'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: true,
                onTap: () => navitateTo(
                  BarcodeScannerPage(
                    cameras: widget.cameras,
                    title: 'Barcode Scanner',
                  ),
                ),
              ),
              ListTile(
                title: Text('Text Recognition'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: true,
                onTap: () => navitateTo(
                  TextRecognitionPage(
                    camera: widget.cameras[0],
                    title: 'Text Recognition',
                  ),
                ),
              ),
              ListTile(
                title: Text('Face Detection'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: true,
                onTap: () => navitateTo(
                  FaceDetectionPage(
                    cameras: widget.cameras,
                    title: 'Face Detection',
                  ),
                ),
              ),
              ListTile(
                title: Text('Text Translation and Language Identification'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: true,
                onTap: () => navitateTo(
                  TextTranslationPage(
                    cameras: widget.cameras,
                    title: 'Text Translations',
                  ),
                ),
              ),
              ListTile(
                title: Text('Image Classification'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: false,
                onTap: () {},
              ),
              ListTile(
                title: Text('Object Detection'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: false,
                onTap: () {},
              ),
              ListTile(
                title: Text('Human Pose Estimation'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: false,
                onTap: () {},
              ),
              ListTile(
                title: Text('Image Segmentation'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: false,
                onTap: () {},
              ),
              ListTile(
                title: Text('Dog Breed Classification'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: false,
                onTap: () {},
              ),
              ListTile(
                title: Text('Fruts Recognition'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: false,
                onTap: () {},
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }
}
