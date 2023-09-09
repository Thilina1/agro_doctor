import 'package:agro_doctor/home_screen.dart';
import 'package:flutter/material.dart';

class ModernCard extends StatelessWidget {
  final IconData iconData;
  final String text;

  ModernCard({required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      width: 125,
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                iconData,
                size: 32.0,
              ),
              const SizedBox(height: 16.0),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Agro Doctor',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              ModernCard(
                iconData: Icons.home,
                text: 'Pests & Diseases',
              ),
              ModernCard(
                iconData: Icons.work,
                text: 'Fertilizer Calculator',
              ),
              ModernCard(
                iconData: Icons.school,
                text: 'Cultivation Tips',
              ),
            ],
          ),
          const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "Heal your crop",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              )),
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
                'images/docbar.png',
                height: 220.0, // Path to your image file
              ),
            ),
          ),
        ],
      ),
    );
  }
}
