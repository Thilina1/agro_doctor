import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyAppMap extends StatelessWidget {
  final String userEmail;
  const MyAppMap({required this.userEmail});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Spread Map',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 3, 2, 2),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: userEmail)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final documents = snapshot.data!.docs;

            if (documents.isEmpty) {
              return const Center(child: Text('No data found'));
            }

            final userDocument = documents.first;
            final userData = userDocument.data() as Map<String, dynamic>?;

            if (userData == null) {
              return const Center(child: Text('User data not found'));
            }

            final wProvince = userData['Province'];

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('spreadMap')
                  .where('locationName', isEqualTo: wProvince)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final documents = snapshot.data!.docs;

                if (documents.isEmpty) {
                  return const Center(child: Text('No data found'));
                }

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    final data = document.data() as Map<String, dynamic>?;

                    if (data == null) {
                      return const SizedBox();
                    }

                    final name = data['name'] ?? 'N/A';
                    final symptoms = data['symptoms'] ?? 'N/A';
                    final solutions = data['solutions'] ?? 'N/A';
                    final Province = data[wProvince] ?? 'N/A';
                    final approve = data['approve'] ?? 'N/A';

                    Color cardColor = Colors.blue;

                    if (Province == '3') {
                      cardColor = Colors.red;
                    }
                    if (Province == '1') {
                      cardColor = Colors.yellow;
                    }
                    if (Province == '0') {
                      cardColor = Colors.green;
                    }

                    return Center(
                        child: approve == '1'
                            ? Card(
                                color: cardColor,
                                child: ListTile(
                                  title: Text(name),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Symptoms: $symptoms'),
                                      Text('Solutions: $solutions'),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink());
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
