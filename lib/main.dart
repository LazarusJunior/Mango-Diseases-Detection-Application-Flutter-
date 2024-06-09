import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mango Disease Classifier',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MangoDiseaseClassifier(),
    );
  }
}

class MangoDiseaseClassifier extends StatefulWidget {
  const MangoDiseaseClassifier({Key? key}) : super(key: key);

  @override
  State<MangoDiseaseClassifier> createState() => _MangoDiseaseClassifierState();
}

class _MangoDiseaseClassifierState extends State<MangoDiseaseClassifier> {
  File? _image;
  String? _prediction;
  double? _confidence;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future _loadModel() async {
    await Tflite.loadModel(
      model: "assets/mangoModel.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future _predictDisease(File image) async {
    print("Image Path: ${image.path}");
    if (!image.existsSync()) {
      print("File does not exist");
      return;
    }

    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    if (recognitions!.isNotEmpty) {
      setState(() {
        _prediction = recognitions[0]['label'];
        _confidence = recognitions[0]['confidence'];
      });
    } else {
      setState(() {
        _prediction = 'No disease detected';
        _confidence = 0.0;
      });
    }
  }

  Future _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _prediction = null; // Reset prediction when a new image is selected
      });
    }
  }

  void _predict() {
    if (_image != null) {
      _predictDisease(_image!);
    } else {
      setState(() {
        _prediction = 'No image selected';
        _confidence = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mango Disease Classifier'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('No image selected')
                : Image.file(_image!, height: 200),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predict,
              child: const Text('Predict'),
            ),
            const SizedBox(height: 20),
            _prediction != null
                ? Column(
                    children: [
                      Text(
                        'Prediction: $_prediction',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Confidence: ${(_confidence ?? 0.0) * 100}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
