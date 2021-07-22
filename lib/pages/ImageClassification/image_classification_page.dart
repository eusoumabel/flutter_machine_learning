import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_learning/utils/helpers.dart';
import 'package:tflite/tflite.dart';

class ImageClassificationPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String title;
  const ImageClassificationPage({
    Key? key,
    required this.cameras,
    required this.title,
  }) : super(key: key);

  @override
  _ImageClassificationPageState createState() =>
      _ImageClassificationPageState();
}

class _ImageClassificationPageState extends State<ImageClassificationPage> {
  late Future<File> imageFile;
  late ImagePicker imagePicker;
  File? _image;
  List<String> results = [];

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    loadModelFiles();
  }

  loadModelFiles() async {
    String? res = await Tflite.loadModel(
      model: "assets/mobilenet_v1_1.0_224.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
  }

  doImageClassification() async {
    results.clear();
    var recognitions = await Tflite.runModelOnImage(
      path: _image!.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 5,
      threshold: 0.2,
      asynch: true,
    );

    if (recognitions != null) {
      recognitions.forEach((element) {
        setState(() {
          results.add(
            "${element['label']} - ${(element['confidence'] as double).toStringAsFixed(2)}",
          );
        });
      });
    }
  }

  _getImageFromCamera() async {
    PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.camera);
    _image = File(pickedFile!.path);
    setState(() {
      _image;
      doImageClassification();
    });
  }

  _getImageFromGallery() async {
    PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile!.path);
    setState(() {
      _image;
      doImageClassification();
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
          //isLive = false;
          Helpers.showCameraOptionsDialog(
            context: context,
            camera: _getImageFromCamera,
            gallery: _getImageFromGallery,
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
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      // isLive
                      //     ? controller.value.isInitialized
                      //         ? AspectRatio(
                      //             aspectRatio: controller.value.aspectRatio,
                      //             child: CameraPreview(controller),
                      //           )
                      //         : Icon(
                      //             Icons.camera_alt,
                      //             color: Colors.grey[500],
                      //           )
                      //     :
                      _image != null
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
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          results[index],
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
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
