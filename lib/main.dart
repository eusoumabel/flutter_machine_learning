import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:machine_learning/pages/splash_page.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Machine Learning',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(cameras: cameras),
    );
  }
}
