import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';

import 'DoctorScreens/find_doctors.dart';

// ignore: prefer_typing_uninitialized_variables
var source;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   List? _outputs;
  File? _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  ImagePicker imagePicker = ImagePicker();

  pickImage() async {
    var image = await imagePicker.pickImage(source: source);
    File? img = image != null ? File(image.path) : null;

    if (img == null) return null;
    setState(() {
      _loading = true;

      _image = img;
    });
    classifyImage(_image!);
  }
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              height: size.height * 0.5,
              width: size.width,
              // TOP CONTAINER
              child: Container(
                  //color: Colors.red,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/background2.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: _loading
                      ? Container(
                          height: 100,
                          width: 100,
                        )
                      : Container(
                          child: _image == null
                              ? Container()
                              : Container(
                                  height: 100,
                                  width: 300,
                                  child: Image.file(_image!),
                                ),
                        ))),
          // BOTTOM CONTAINER
          Positioned(
            top: size.height * 0.45,
            height: size.height * 0.65,
            width: size.width,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(36.0)),
              ),
              // PREDICTED TEXT
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Disease Name',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  _image == null
                      ? const Text(
                          'skin cancer',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          _outputs?[0]["label"],
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                        ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  // OUR BUTTONS ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // FIRST BUTTON
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                source = ImageSource.camera;
                              });
                              pickImage();
                            },
                            child: const Icon(
                              Icons.camera_alt,
                              size: 35,
                              color: Colors.orange,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              'Camera',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 40.0,
                      ),
                      // SECOND BUTTON
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                source = ImageSource.gallery;
                              });
                              pickImage();
                            },
                            child: const Icon(
                              Icons.photo,
                              size: 35,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              'Gallery',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0,),
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FindDoctors()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white38,
                  ), 
                  child: const Text('Consult Doctor'),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}