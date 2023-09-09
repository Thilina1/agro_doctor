import 'package:cached_network_image/cached_network_image.dart';
import 'package:agro_doctor/home_screen.dart';
import 'package:agro_doctor/pages/homecard/search.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DismainSin extends StatefulWidget {
  const DismainSin({Key? key}) : super(key: key);

  @override
  State<DismainSin> createState() => _DismainSinState();
}

class _DismainSinState extends State<DismainSin> {
  String? selectedCrop;
  List<String> crops = ['වී', 'තක්කාලි', 'කැරට්'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'පළිබෝධ සහ රෝග',
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
                          'පළිබෝධ සහ රෝග සොයන්න',
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
                labelText: 'තෝරන්න',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (selectedCrop != null)
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('treatD')
                  .where('cropSin', isEqualTo: selectedCrop)
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
                                      disease['NameSin'] as String,
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
          title: Text(disease['Diseases'] as String),
          backgroundColor: Colors.white,
          leading: const BackButton(color: Colors.black),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'රෝග විනිශ්චය තහවුරු කරන්න',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 7),
                  CachedNetworkImage(
                    imageUrl: disease['image'],
                    width: 500,
                  ),
                  const Text(
                    'රෝග ලක්ෂණ:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(disease['descriptionSin 1']),
                  const SizedBox(height: 7),
                  Text(disease['discription']),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                        child: SizedBox(
                      height: 100,
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
                            "ඕනෑම ක්‍රියාමාර්ගයක් ගැනීමට පෙර මෙම රෝග විනිශ්චය ඔබගේ ගැටලුවට ගැලපෙන බව තහවුරු කර ගැනීමට රෝග ලක්ෂණ කියවන්න",
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
                    'ප්‍රතිකාර කරන්න',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text(
                    "රෝගයට ගොදුරු වූ ශාක ඉවත් කරන්න",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    "සෞඛ්‍ය සම්පන්න ශාක වලින් අපවිත්‍ර වීම වළක්වා ගැනීම සඳහා ආක්‍රමණශීලී පැල හොඳින් උදුරා විනාශ කරන්න",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const Text(
                    "Pick a Product",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 800,
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
                            'ඔබේ භෝග සඳහා පහත නිෂ්පාදන වලින් එකක් පමණක් තෝරා අයදුම් කරන්න',
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
                          Text(
                            disease['1solSin'],
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
                          Text(disease['2solSin']),
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
                          Text(disease['3solSin']),
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
                          Text(disease['4solSin']),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 800,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(213, 248, 115, 6),
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
                            'භාණ්ඩයක් මිල දී ගැනීමේදී, බහාලුම් ලේබලයේ ඉහත සඳහන් ක්‍රියාකාරී අමුද්‍රව්‍ය ලියා ඇති බවට වග බලා ගන්න.',
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
            ),
          ],
        ));
  }
}
