// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TreatPageSin extends StatelessWidget {
  final String label;

  const TreatPageSin({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ප්‍රතිකාර',
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
              'රෝගය : $label',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: label == '2 Potato Late blight'
                ? Text("")
                : label == "3 Tomato Early blight"
                    ? Text("3 තක්කාලි මුල් අංගමාරය")
                    : label == "0 Potato Early blight"
                        ? Text("0 අර්තාපල් මුල් අංගමාරය")
                        : label == "1 Potato healthy"
                            ? Text("1 අර්තාපල් සෞඛ්ය සම්පන්න")
                            : label == "2 Potato Late blight"
                                ? Text("2 අර්තාපල් ප්‍රමාද අංගමාරය")
                                : label == "4 Tomato healthy"
                                    ? Text("4 තක්කාලි සෞඛ්ය සම්පන්න")
                                    : label == "5 Tomato Late blight"
                                        ? Text("5 තක්කාලි ප්‍රමාද අංගමාරය")
                                        : label == "6 Tomato Septoria leaf spo"
                                            ? Text("Draw")
                                            : label ==
                                                    "7 Spider mites Two spotted spider mite"
                                                ? Text(
                                                    "7 Spider mites Two spotted spider mite")
                                                : label ==
                                                        "8 Tomato Target Spot"
                                                    ? Text(
                                                        "තක්කාලි Target Spot")
                                                    : label ==
                                                            "9 Tomato mosaic virus"
                                                        ? Text(
                                                            "9 තක්කාලි මොසෙයික් වෛරසය")
                                                        : label ==
                                                                "10 Tomato Yellow Leaf Curl Virus"
                                                            ? Text(
                                                                "10 තක්කාලි කහ කොළ කරල් වෛරසය")
                                                            : Text(
                                                                "No Finding"),
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
      final description1 = treatmentData['descriptionSin 1'];
      final description = treatmentData['discriptionSin'];
      final image = treatmentData['image'];
      final sol1 = treatmentData['1solSin'];
      final sol2 = treatmentData['2solSin'];
      final sol3 = treatmentData['3solSin'];
      final sol4 = treatmentData['4solSin'];
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
          'ප්‍රතිකාර $name',
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
            'රෝග විනිශ්චය තහවුරු කරගන්න',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          const Text(
            'රෝග ලක්ෂණ',
            style: TextStyle(fontSize: 18),
          ),
          Text(description1),
          const SizedBox(height: 10),
          Text(description),
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
                  const Text(
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
            "ප්රතිකාර සදහා  උපදෙස්",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 14,
          ),
          const Text(
            "රෝගය ඇති වූ ශාක ඉවත් කරන්න",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const Text(
            "සෞඛ්‍ය සම්පන්න ශාක ආරක්ෂා කර  ගැනීම සඳහා ආක්‍රමණශීලී ශාක හොඳින් උදුරා විනාශ කරන්න",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "ප්රවේශයක් තෝරා පළිබෝධනාශකයක් යොදන්න",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const Text(
            "අපගේ රසායනික හෝ ජීව විද්‍යාත්මක නිර්දේශ වලින් නිෂ්පාදනයක් තෝරා උපදෙස් අනුගමනය කිරීමෙන් පසු එය ඔබේ බෝග වලට යොදන්න",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "නිෂ්පාදනයක් තෝරන්න",
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
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(213, 248, 115, 6),
            ),
            child: const SizedBox(
              height: 150,
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
                    'භාණ්ඩයක් මිල දී ගැනීමේදී, බහාලුම් ලේබලයේ ඉහත සඳහන් ක්‍රියාකාරී අමුද්‍රව්‍ය ලියා ඇති බවට තහවුරු කරගැනීමට වග බලා ගන්න.',
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
            height: 30,
          ),
          const Text(
            "වැදගත් ආරක්ෂිත පූර්වාරක්ෂාවන්",
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
