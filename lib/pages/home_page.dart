import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:machine_learning/pages/ImageLabeling/image_labeling_page.dart';

class HomePage extends StatefulWidget {
  final CameraDescription camera;
  const HomePage({Key? key, required this.camera}) : super(key: key);

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
        title: Text("Machile Learning"),
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
                    camera: widget.camera,
                    title: 'Image Labeling',
                  ),
                ),
              ),
              ListTile(
                title: Text('Barcode Scanner'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: true,
                onTap: () {},
              ),
              ListTile(
                title: Text('Text Recognition'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: false,
                onTap: () {},
              ),
              ListTile(
                title: Text('Face Detection'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: false,
                onTap: () {},
              ),
              ListTile(
                title: Text('Text Translation and Language Identification'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: false,
                onTap: () {},
              ),
              ListTile(
                title: Text('Face Detection'),
                trailing: Icon(Icons.keyboard_arrow_right),
                enabled: false,
                onTap: () {},
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
