import 'package:flutter/material.dart';
import 'package:agro_doctor/pages/homecard/tipDetails/displaytip1.dart';
import 'package:agro_doctor/pages/homecard/tipDetails/displaytip10.dart';
import 'package:agro_doctor/pages/homecard/tipDetails/displaytip11.dart';
import 'package:agro_doctor/pages/homecard/tipDetails/displaytip12.dart';
import 'package:agro_doctor/pages/homecard/tipDetails/displaytip2.dart';
import 'package:agro_doctor/pages/homecard/tipDetails/displaytip3.dart';
import 'package:agro_doctor/pages/homecard/tipDetails/displaytip4.dart';
import 'package:agro_doctor/pages/homecard/tipDetails/displaytip5.dart';
import 'package:agro_doctor/pages/homecard/tipDetails/displaytip6.dart';
import 'package:agro_doctor/pages/homecard/tipDetails/displaytip7.dart';
import 'package:agro_doctor/pages/homecard/tipDetails/displaytip8.dart';
import 'package:agro_doctor/pages/homecard/tipDetails/displaytip9.dart';

class TabBarExampleSin extends StatefulWidget {
  const TabBarExampleSin({Key? key}) : super(key: key);

  @override
  _TabBarExampleSinState createState() => _TabBarExampleSinState();
}

class _TabBarExampleSinState extends State<TabBarExampleSin>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? selectedVegetable;

  List<String> vegetables = [
    'වී '
        'තක්කාලි',
    'කැරට්',
    'නිවිති',
    'ගෝවා',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void onVegetableSelected(String? vegetable) {
    setState(() {
      selectedVegetable = vegetable;
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          tabs: const [
            Tab(
              text: 'By Task',
            ),
            Tab(text: 'By Growing date'),
          ],
        ),
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1 content
          SingleChildScrollView(
            child: Column(
              children: [
                DropdownButton<String>(
                  value: selectedVegetable,
                  onChanged: onVegetableSelected,
                  items: vegetables.map((String vegetable) {
                    return DropdownMenuItem<String>(
                      value: vegetable,
                      child: Text(vegetable),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TipsPage1(selectedVegetable),
                            ),
                          );
                        },
                        child: Image.asset(
                          'images/tipsIcon/12.png',
                          width: 250,
                          height: 150,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TipsPage2(selectedVegetable),
                            ),
                          );
                        },
                        child: Image.asset(
                          'images/tipsIcon/11.png',
                          width: 250,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TipsPage3(selectedVegetable),
                            ),
                          );
                        },
                        child: Image.asset(
                          'images/tipsIcon/10.png',
                          width: 250,
                          height: 150,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TipsPage4(selectedVegetable),
                            ),
                          );
                        },
                        child: Image.asset(
                          'images/tipsIcon/9.png',
                          width: 250,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print('Image button 5 tapped');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TipsPage5(selectedVegetable)),
                          );
                        },
                        child: Image.asset(
                          'images/tipsIcon/8.png',
                          width: 250,
                          height: 150,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print('Image button 5 tapped');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TipsPage6(selectedVegetable)),
                          );
                        },
                        child: Image.asset(
                          'images/tipsIcon/7.png',
                          width: 250,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print('Image button 5 tapped');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TipsPage7(selectedVegetable)),
                          );
                        },
                        child: Image.asset(
                          'images/tipsIcon/6.png',
                          width: 250,
                          height: 150,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print('Image button 5 tapped');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TipsPage8(selectedVegetable)),
                          );
                        },
                        child: Image.asset(
                          'images/tipsIcon/5.png',
                          width: 250,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print('Image button 5 tapped');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TipsPage9(selectedVegetable)),
                          );
                        },
                        child: Image.asset(
                          'images/tipsIcon/4.png',
                          width: 250,
                          height: 150,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print('Image button 5 tapped');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TipsPage10(selectedVegetable)),
                          );
                        },
                        child: Image.asset(
                          'images/tipsIcon/3.png',
                          width: 250,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print('Image button 5 tapped');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TipsPage11(selectedVegetable)),
                          );
                        },
                        child: Image.asset(
                          'images/tipsIcon/2.png',
                          width: 250,
                          height: 150,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print('Image button 5 tapped');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TipsPage12(selectedVegetable)),
                          );
                        },
                        child: Image.asset(
                          'images/tipsIcon/1.png',
                          width: 250,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
