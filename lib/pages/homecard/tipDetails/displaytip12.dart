import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TipsPage12 extends StatefulWidget {
  final String? selectedVegetable;

  const TipsPage12(this.selectedVegetable, {Key? key}) : super(key: key);

  @override
  _TipsPage12State createState() => _TipsPage12State();
}

class _TipsPage12State extends State<TipsPage12> {
  List<Map<String, dynamic>> tips = [];

  Future<void> fetchData() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('tips')
          .where('id', isEqualTo: '12')
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
          'Post Harvest - ${widget.selectedVegetable}',
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
                const SizedBox(
                  height: 20,
                ),
                Text(tip['note1']),
                const SizedBox(
                  height: 20,
                ),
                Image.network(tip['image1']),
              ],
            ),
          );
        },
      ),
    );
  }
}
