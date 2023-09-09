import 'package:agro_doctor/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class tips extends StatefulWidget {
  const tips({Key? key}) : super(key: key);

  @override
  State<tips> createState() => _tipsState();
}

class _tipsState extends State<tips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cultivation Tips',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('tips')
                .where('crop')
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      disease['image1'] as String,
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
                                    disease['selectedVegetableSin'] as String,
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
          disease['selectedVegetableSin'],
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.network(
            disease['image1'],
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

          const SizedBox(height: 15),
          Text(disease['introSin']),
          const SizedBox(height: 10),
          const Text(
            'නිකුත් කරන ලද ප්‍රභේද',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            disease['Varieties'],
          ),
          const SizedBox(height: 15),

          // const Text(
          //   'දේශගුණික අවශ්‍යතා / වගාවට සුදුසු ප්‍රදේශ',
          //  style: TextStyle(fontSize: 18),
          // ),
          const SizedBox(height: 5),
          // Text(disease['climateSin']),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "පස",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(disease['soilSin']),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "බීජ අවශ්‍යතාවය",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(disease['seedReqSin']),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "තවාන් කළමනාකරණය",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(disease['nManSin']),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "බිම් සැකසීම",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(disease['lPreSin']),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "පැළ සිටුවීම",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(disease['plantingSin']),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "පොහොර",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(disease['fertilizerSin']),
          const SizedBox(
            height: 10,
          ),
          Image.network(
            disease['ferImg'],
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
          const Text(
            "පැළ සිටුවීම",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(disease['nManSin']),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "ජල සම්පාදනය",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(disease['waterSin']),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "වල් පැළෑටි පාලනය",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(disease['wConSin']),
        ],
      ),
    );
  }
}
