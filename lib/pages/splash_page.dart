import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const SplashPage({Key? key, required this.cameras}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadData() async {
    await Future.delayed(new Duration(seconds: 4));
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => HomePage(
          cameras: widget.cameras,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 128, bottom: 64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  _image(),
                  _textTitle(),
                ],
              ),
              _textSubTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return Image.asset("images/splash_pic.png");
  }

  Widget _textTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: Text(
        "Machine Learning",
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _textSubTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 64),
      child: Text(
        "Where the magic happens!",
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Colors.white,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
