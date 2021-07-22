import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TextTranslationPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String title;
  const TextTranslationPage({
    Key? key,
    required this.cameras,
    required this.title,
  }) : super(key: key);

  @override
  _TextTranslationPageState createState() => _TextTranslationPageState();
}

class _TextTranslationPageState extends State<TextTranslationPage> {
  //FIXME PACKAGE NÃO ESTÁ ATUALIZADO PARA NULL SAFETY
  TextEditingController translateTextController = TextEditingController();
  String? result;
  // late LanguageIdentifier languageIdentifier;
  // late ModelManager modelManager;
  // late LanguageTranslator languageTranslator;

  @override
  void initState() {
    super.initState();
    // modelManager = FirebaseLanguage.instance.modelManager();
    // modelManager.downloadModel(SupportedLanguages.Portuguese);
    // languageIdentifier = FirebaseLanguage.instance.languageIdentifier();
  }

  translateText(String text) async {
    // languageTranslator = FirebaseLanguage.instance.languageTranslator(
    //   SupportedLanguages.English,
    //   SupportedLanguages.Portuguese,
    // );
    // String res = await languageTranslator.processText(text);
    // setState(() {
    //   result = res;
    // });

    // final List<LanguageLabel> labels =
    //     await languageIdentifier.processText(result);
    // for (LanguageLabel label in labels) {
    //   final String text = label.languageCode;
    //   final double confidence = label.confidence;
    //   setState(() {
    //     result = result! + " " + text;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.ac_unit_rounded),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'English',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.blue,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Portuguese',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: translateTextController,
                      style: TextStyle(color: Colors.black),
                      maxLines: 10,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Type text here...',
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => translateText(
                    translateTextController.text,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 15, left: 13, right: 13),
                    padding: EdgeInsets.fromLTRB(0, 18, 0, 18),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(4, 4),
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Translate'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: (result != null),
                  child: Container(
                    margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        result == null ? "" : result!,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
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
