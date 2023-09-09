import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataScreen extends StatefulWidget {
  @override
  _FirestoreDataScreenState createState() => _FirestoreDataScreenState();
}

class _FirestoreDataScreenState extends State<FirestoreDataScreen> {
  Future<QuerySnapshot> fetchDataFromFirestore() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: 'Thilina Weerasinghe')
        .get();

    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Data'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: fetchDataFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            final documents = snapshot.data!.docs;
            if (documents.isNotEmpty) {
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final datad = documents[index].data() as Map<String, dynamic>;
                  final named = datad['name'];
                  final aged = datad['age'];
                  final occupationd = datad['occupation'];
                  final locationd = datad['location'];

                  return ListTile(
                    title: Text(named),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Age: $aged'),
                        Text('Occupation: $occupationd'),
                        Text('Location: $locationd'),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No data found for Thilina Weerasinghe.'),
              );
            }
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred: ${snapshot.error.toString()}'),
            );
          }

          return Center(
            child: Text('No data found.'),
          );
        },
      ),
    );
  }
}
