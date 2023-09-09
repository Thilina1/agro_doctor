import 'package:agro_doctor/pages/price/more_info_price.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VegPricePage extends StatefulWidget {
  @override
  _VegPricePageState createState() => _VegPricePageState();
}

class _VegPricePageState extends State<VegPricePage> {
  String selectedLocation = 'Dambulla';
  List<DocumentSnapshot> vegPrices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vegetable Prices',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'තෝරන්න',
              border: OutlineInputBorder(),
            ),
            value: selectedLocation,
            onChanged: (String? newValue) {
              setState(() {
                selectedLocation = newValue!;
              });
              fetchVegPrices(selectedLocation);
            },
            items: const [
              DropdownMenuItem(
                value: 'Dambulla',
                child: Text('දඹුල්ල'),
              ),
              DropdownMenuItem(
                value: 'Kandy',
                child: Text('මහනුවර'),
              ),
              DropdownMenuItem(
                value: 'Peliyagoda',
                child: Text('පෑලියගොඩ'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: vegPrices.length,
              itemBuilder: (context, index) {
                final price = vegPrices[index];
                final name = price['namesin'];
                final range1 = price['date1'];
                final range2 = price['date2'];
                final image = price['image'];

                return Card(
                    child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        ListTile(
                            title: Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Rs: $range1 - Rs: $range2',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    )),
                    SizedBox(
                      width: 100,
                      child: Image.network(
                        '$image',
                        fit: BoxFit.cover,
                        alignment: Alignment.topRight,
                      ),
                    ),
                  ],
                ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchVegPrices(String location) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('vegPrice')
        .where('location', isEqualTo: location)
        .get();

    setState(() {
      vegPrices = querySnapshot.docs;
    });
  }
}
