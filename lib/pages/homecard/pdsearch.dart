import 'package:agro_doctor/home_screen.dart';
import 'package:agro_doctor/pages/homecard/search.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dismain extends StatefulWidget {
  const Dismain({Key? key}) : super(key: key);

  @override
  State<Dismain> createState() => _DismainState();
}

class _DismainState extends State<Dismain> {
  String? selectedCrop;
  List<String> crops = [
    'Paddy',
    'Tomato',
    'Carrot',
    'Brinjal',
    'Cabbage',
    'Radish'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pests & Diseases',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(
        children: [
          SizedBox(
            width: 120,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePages(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, foregroundColor: Colors.black),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    child: Row(
                      children: [
                        SizedBox(height: 40),
                        Icon(Icons.bug_report),
                        SizedBox(
                          height: 20,
                          width: 20,
                        ),
                        Text(
                          'Search Pests and Diseases',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: selectedCrop,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCrop = newValue;
                });
              },
              items: crops.map((crop) {
                return DropdownMenuItem<String>(
                  value: crop,
                  child: Text(crop),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Select Crop',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (selectedCrop != null)
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('treatD')
                  .where('crop', isEqualTo: selectedCrop)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  final diseases = snapshot.data!.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: diseases.length,
                    itemBuilder: (context, index) {
                      final disease = diseases[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiseaseDetailsPage(
                                disease: disease,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        disease['image'] as String,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      disease['Diseases'] as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: Image.asset(
                "images/icon/background carddiago.png",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiseaseDetailsPage extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> disease;

  const DiseaseDetailsPage({Key? key, required this.disease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          disease['Diseases'],
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.network(
            disease['image'],
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
          Text(disease['description 1']),
          const SizedBox(height: 10),
          Text(disease['discription']),
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
                  Text(
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
                  Text(disease['1sol']),
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
                  Text(disease['2sol']),
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
                  Text(disease['3sol']),
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
                  Text(disease['4sol']),
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
          SizedBox(
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
