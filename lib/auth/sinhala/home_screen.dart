import 'dart:io';
import 'package:agro_doctor/auth/sinhala/treat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ImagePicker imagePicker;
  File? img;
  String result = '';
  late List output;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    loadModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  detectImage() async {
    var recognitions = await Tflite.runModelOnImage(
      path: img!.path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );
    setState(() {
      output = recognitions!;
    });
  }

  loadModel() async {
    result = (await Tflite.loadModel(
      model: "assets/ml/model_unquant.tflite",
      labels: "assets/ml/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    ))!;
  }

  imgFromGallery() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    img = File(image!.path);
    setState(() {
      img;
      detectImage();
    });
  }

  imgFromCamera() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera);
    img = File(image!.path);
    setState(() {
      img;
      detectImage();
    });
  }

  void _navigateToTreatPage() {
    if (output.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TreatPageSin(label: output[0]['label']),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          'Agro Doctor',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: img == null
                      ? SizedBox(
                          width: 400,
                          child: Column(
                            children: [
                              Image.asset('images/scan.png'),
                            ],
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Image.file(img!),
                              const SizedBox(height: 15),
                              Text(
                                'ප්‍රතිඵලය: ${output[0]['label']}.\t',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          imgFromGallery();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 100,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 50, 11, 221),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 15,
                                color: Color.fromARGB(255, 204, 201, 201),
                                offset: Offset(10, 10),
                              )
                            ],
                          ),
                          child: const Text(
                            'ගැලරිය විවෘත කරන්න',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          imgFromCamera();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 18,
                          ),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 47, 22, 160),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 25,
                                color: Color.fromARGB(255, 170, 168, 168),
                                offset: Offset(10, 10),
                              )
                            ],
                          ),
                          child: const Text(
                            'කැමරාව',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToTreatPage,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
