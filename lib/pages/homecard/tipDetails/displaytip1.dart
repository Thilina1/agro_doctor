import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TipsPage1 extends StatefulWidget {
  final String? selectedVegetable;

  const TipsPage1(this.selectedVegetable, {Key? key}) : super(key: key);

  @override
  _TipsPage1State createState() => _TipsPage1State();
}

class _TipsPage1State extends State<TipsPage1> {
  List<Map<String, dynamic>> tips = [];

  Future<void> fetchData() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('tips')
          .where('id', isEqualTo: '1')
          .where('selectedVegetable', isEqualTo: widget.selectedVegetable)
          .get();

      setState(() {
        tips = snapshot.docs.map((DocumentSnapshot document) {
          return document.data() as Map<String, dynamic>;
        }).toList();
      });
    } catch (error) {
      // Handle error
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Plant Selection - ${widget.selectedVegetable}',
          style: const TextStyle(color: Colors.black),
        ),
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final tip = tips[index];
          return ListTile(
            title: Text(
              tip['name'],
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      tip['image1'],
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Varieties",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      tip['Varieties'],
                    ),
                    Text(
                      tip['note2'],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
