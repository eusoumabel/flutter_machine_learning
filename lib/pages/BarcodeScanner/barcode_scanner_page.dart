import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_learning/utils/helpers.dart';

class BarcodeScannerPage extends StatefulWidget {
  final CameraDescription camera;
  final String title;
  const BarcodeScannerPage({
    Key? key,
    required this.camera,
    required this.title,
  }) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  late final BarcodeScanner barcodeScanner;
  late ImagePicker imagePicker;
  late Future<File> imageFile;
  late CameraController controller;
  late CameraImage _liveImage;
  File? _image;
  String? result = '';
  bool isBusy = false;
  bool isLive = false;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    barcodeScanner = GoogleMlKit.vision.barcodeScanner();
    controller = CameraController(widget.camera, ResolutionPreset.max);
  }

  @override
  void dispose() {
    super.dispose();
    barcodeScanner.close();
  }

  _getImageFromCamera() async {
    setState(() {
      isLive = false;
      controller.stopImageStream();
    });

    PickedFile? image = await imagePicker.getImage(
      source: ImageSource.camera,
    );

    setState(() {
      _image = File(image!.path);

      if (_image != null) {
        doBarcodeScanning(inputImage: InputImage.fromFile(_image!));
      }
    });
  }

  _getImageFromGallery() async {
    setState(() {
      isLive = false;
      controller.stopImageStream();
    });
    PickedFile? image = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _image = File(image!.path);

      if (_image != null) {
        doBarcodeScanning(inputImage: InputImage.fromFile(_image!));
      }
    });
  }

  _getLiveCamera() async {
    controller = CameraController(widget.camera, ResolutionPreset.max);
    await controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller.startImageStream((image) {
        if (!isBusy) {
          setState(() {
            isBusy = true;
            _liveImage = image;
            isLive = true;
            doBarcodeScanning(inputImage: getLiveInputImage(_liveImage));
          });
        }
      });
    });
    setState(() {});
  }

  doBarcodeScanning({required InputImage inputImage}) async {
    result = '';
    final _inputImage = inputImage;

    final List<Barcode> barcodes =
        await barcodeScanner.processImage(_inputImage);
    for (Barcode barcode in barcodes) {
      final BarcodeType type = barcode.type;
      final Rect? boundingBox = barcode.value.boundingBox;
      final String? displayValue = barcode.value.displayValue;
      final String? rawValue = barcode.value.rawValue;

      switch (type) {
        case BarcodeType.wifi:
          BarcodeWifi barcodeWifi = barcode.value as BarcodeWifi;
          setState(() {
            result = barcodeWifi.password;
          });
          break;
        case BarcodeType.url:
          BarcodeUrl barcodeUrl = barcode.value as BarcodeUrl;
          setState(() {
            result = barcodeUrl.rawValue;
          });
          break;
        case BarcodeType.email:
          BarcodeEmail barcodeEmail = barcode.value as BarcodeEmail;
          setState(() {
            result = barcodeEmail.displayValue;
          });
          break;
        case BarcodeType.phone:
          BarcodePhone barcodePhone = barcode.value as BarcodePhone;
          setState(() {
            result = barcodePhone.rawValue;
          });
          break;
        default:
          setState(() {
            result = 'Barcode not identified.';
          });
          break;
      }
    }
    isBusy = false;
  }

  InputImage getLiveInputImage(CameraImage image) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final InputImageRotation imageRotation =
        InputImageRotationMethods.fromRawValue(
                widget.camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final InputImageFormat inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    return inputImage;
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
            live: _getLiveCamera,
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
                  child: isLive
                      ? controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              child: CameraPreview(controller),
                            )
                          : Icon(
                              Icons.camera_alt,
                              color: Colors.grey[500],
                            )
                      : _image != null
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
                    title: Text(
                      result!,
                      textAlign: TextAlign.center,
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
