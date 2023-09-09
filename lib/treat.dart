// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

class TreatPage extends StatelessWidget {
  final String label;

  const TreatPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Treat',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Treatment for: $label',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _fetchTreatmentData(context),
            child: const Text('Suggest Treatment'),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchTreatmentData(BuildContext context) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('treatD')
        .where('Name', isEqualTo: label)
        .get();

    if (snapshot.docs.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Data Found'),
            content: const Text('No treatment data available for this.'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      final treatmentData = snapshot.docs.first.data();
      final name = treatmentData['Name'];
      final description1 = treatmentData['description 1'];
      final description = treatmentData['discription'];
      final image = treatmentData['image'];
      final sol1 = treatmentData['1sol'];
      final sol2 = treatmentData['2sol'];
      final sol3 = treatmentData['3sol'];
      final sol4 = treatmentData['4sol'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TreatmentView(
            name: name,
            description1: description1,
            description: description,
            image: image,
            sol1: sol1,
            sol2: sol2,
            sol3: sol3,
            sol4: sol4,
          ),
        ),
      );
    }
  }
}

class TreatmentView extends StatelessWidget {
  final String name;
  final String description1;
  final String description;
  final String image;
  final String sol1;
  final String sol2;
  final String sol3;
  final String sol4;
  const TreatmentView({
    Key? key,
    required this.name,
    required this.description1,
    required this.description,
    required this.image,
    required this.sol1,
    required this.sol2,
    required this.sol3,
    required this.sol4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Treatment For $name',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.network(
            image,
            loadingBuilder: (context, child, progress) {
              if (progress == null) {
                return child;
              }
              return CircularProgressIndicator();
            },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error);
            },
          ),
          const SizedBox(height: 10),
          const Text(
            'Confirm The diagnosis',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 7),
          const Text(
            'Symptoms',
            style: TextStyle(fontSize: 18),
          ),
          Text(description1),
          const SizedBox(height: 10),
          Text(description),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
                child: SizedBox(
              height: 80,
              child: Column(
                children: [
                  SizedBox(
                    child: Icon(
                      Icons.warning,
                      color: Color.fromARGB(255, 73, 73, 37),
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Before taking any action read the symptoms to make sure this diagnosis matches your problram",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )),
          ),
          const SizedBox(
            height: 14,
          ),
          const Text(
            "Treatment Instructons",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 7,
          ),
          const Text(
            "Remove Plants Inflected by the disease",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const Text(
            "Throughly uproot anddistroy inflected plants to avoid contamination with healthy plants",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Select an approach and apply a pesticide",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const Text(
            "Choose a product from our chemical or biological recomendatons and apply it to your crops by following the instructions",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Pick a Product",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 200,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 248, 244, 6),
            ),
            child: const SizedBox(
              width: 140,
              height: 50,
              child: Column(
                children: [
                  SizedBox(
                    child: Icon(
                      Icons.warning,
                      color: Color.fromARGB(255, 73, 73, 37),
                      size: 30,
                    ),
                  ),
                  Text(
                    'Select and apply ONLY ONE of the following product to your crops',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 14, 13, 5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  SizedBox(
                    child: Image.asset('images/icon/spray.png'),
                  ),
                  Text(sol1),
                ],
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  SizedBox(
                    child: Image.asset('images/icon/spray.png'),
                  ),
                  Text(sol2),
                ],
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  SizedBox(
                    child: Image.asset('images/icon/spray.png'),
                  ),
                  Text(sol3),
                ],
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  SizedBox(
                    child: Image.asset('images/icon/spray.png'),
                  ),
                  Text(sol4),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(213, 248, 115, 6),
            ),
            child: const SizedBox(
              width: 140,
              height: 50,
              child: Column(
                children: [
                  const SizedBox(
                    child: Icon(
                      Icons.warning,
                      color: Color.fromARGB(255, 73, 73, 37),
                      size: 30,
                    ),
                  ),
                  const Text(
                    'When buying a product, make sure the above mentioned active ingredient is written on the container label.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 14, 13, 5),
                    ),
                  ),
                ],
              ),
            ),
          ),
         const SizedBox(
            height: 20,
          ),
          const Text(
            "Important Safety Precations",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            child: Image.asset("images/tipsIcon/safety.png"),
          )
        ],
      ),
    );
  }
}
