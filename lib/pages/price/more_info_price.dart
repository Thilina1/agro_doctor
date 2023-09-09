import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MoreInfoPrice extends StatelessWidget {
  final DocumentSnapshot price;

  const MoreInfoPrice({required this.price});

  @override
  Widget build(BuildContext context) {
    // Extract the fields from the price document
    final name = price['name'];
    final location = price['location'];
    final date1 = price['date1'];
    final date2 = price['date2'];
    final date3 = price['date3'];
    final date4 = price['date4'];
    final date5 = price['date5'];
    final date6 = price['date6'];
    final date7 = price['date7'];

    return Scaffold(
      appBar: AppBar(
        title: Text('More Info'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: $name'),
          Text('Location: $location'),
          Text('Date 1: $date1'),
          Text('Date 2: $date2'),
          Text('Date 3: $date3'),
          Text('Date 4: $date4'),
          Text('Date 5: $date5'),
          Text('Date 6: $date6'),
          Text('Date 7: $date7'),
        ],
      ),
    );
  }
}
