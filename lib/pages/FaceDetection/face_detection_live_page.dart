import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceDetectionLivePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String title;
  const FaceDetectionLivePage({
    Key? key,
    required this.cameras,
    required this.title,
  }) : super(key: key);

  @override
  _FaceDetectionLivePageState createState() => _FaceDetectionLivePageState();
}

class _FaceDetectionLivePageState extends State<FaceDetectionLivePage> {
  late CameraController? controller;
  bool isBusy = false;
  late FaceDetector detector;
  late Size size;
  late List<Face> faces;
  late CameraImage img;
  late CameraDescription description;
  CameraLensDirection camDirec = CameraLensDirection.front;

  @override
  void initState() {
    super.initState();
    description = widget.cameras[1];
    initializeCamera();
  }

  @override
  void dispose() {
    controller!.dispose();
    detector.close();
    super.dispose();
  }

  initializeCamera() async {
    controller = CameraController(description, ResolutionPreset.medium);
    detector = GoogleMlKit.vision.faceDetector();
    await controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller!.startImageStream((image) {
        if (!isBusy) {
          isBusy = true;
          img = image;
          doFaceDetectionOnFrame(image);
        }
      });
    });
    setState(() {});
  }

  InputImage getInputImage() {
    final WriteBuffer allBytes = WriteBuffer();
    for (var plane in img.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(img.width.toDouble(), img.height.toDouble());

    final InputImageRotation imageRotation =
        InputImageRotationMethods.fromRawValue(description.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final InputImageFormat inputImageFormat =
        InputImageFormatMethods.fromRawValue(img.format.raw) ??
            InputImageFormat.NV21;

    final planeData = img.planes.map(
      (var plane) {
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

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      inputImageData: inputImageData,
    );
    return inputImage;
  }

  dynamic _scanResults;
  doFaceDetectionOnFrame(CameraImage img) async {
    InputImage inputImage = getInputImage();
    faces = await detector.processImage(inputImage);
    setState(() {
      _scanResults = faces;
    });
  }

  Widget buildResult() {
    if (_scanResults == null ||
        controller == null ||
        !controller!.value.isInitialized) {
      return Text('');
    }

    final Size imageSize = Size(
      controller!.value.previewSize!.height,
      controller!.value.previewSize!.width,
    );
    isBusy = false;
    CustomPainter painter = FaceDetectorPainter(
      imageSize,
      _scanResults,
      camDirec,
    );
    return CustomPaint(
      painter: painter,
    );
  }

  void _toggleCameraDirection() async {
    if (camDirec == CameraLensDirection.back) {
      camDirec = CameraLensDirection.front;
      description = widget.cameras[1];
    } else {
      camDirec = CameraLensDirection.back;
      description = widget.cameras[0];
    }

    await controller!.stopImageStream();
    await controller!.dispose();

    setState(() {
      controller = null;
      initializeCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _toggleCameraDirection,
            icon: Icon(
              Icons.cameraswitch,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller!.value.isInitialized
                    ? Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height - 80,
                            child: AspectRatio(
                              aspectRatio: controller!.value.aspectRatio,
                              child: CameraPreview(controller!),
                            ),
                          ),
                          buildResult(),
                        ],
                      )
                    : Container(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.absoluteImageSize, this.faces, this.camDire2);

  final Size absoluteImageSize;
  final List<Face> faces;
  CameraLensDirection camDire2;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    for (Face face in faces) {
      canvas.drawRect(
        Rect.fromLTRB(
          camDire2 == CameraLensDirection.front
              ? (absoluteImageSize.width - face.boundingBox.right) * scaleX
              : face.boundingBox.left * scaleX,
          face.boundingBox.top * scaleY,
          camDire2 == CameraLensDirection.front
              ? (absoluteImageSize.width - face.boundingBox.left) * scaleX
              : face.boundingBox.right * scaleX,
          face.boundingBox.bottom * scaleY,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}
