import 'package:agro_doctor/auth/cultivationtips.dart';
import 'package:agro_doctor/auth/sinhala/calender.dart';
import 'package:agro_doctor/auth/sinhala/cultivationtips.dart';
import 'package:agro_doctor/auth/sinhala/home_screen.dart';
import 'package:agro_doctor/auth/sinhala/news.dart';
import 'package:agro_doctor/auth/sinhala/pdsearch.dart';
import 'package:agro_doctor/pages/homecard/cal.dart';
import 'package:agro_doctor/pages/homecard/pdsearch.dart';
import 'package:agro_doctor/pages/homecard/saveData.dart';
import 'package:agro_doctor/pages/homecard/tudo.dart';
import 'package:agro_doctor/pages/map/imapSin.dart';
import 'package:agro_doctor/pages/price/priceSin.dart';
import 'package:agro_doctor/pages/weather/weeklyreport.dart';
import 'package:agro_doctor/xml.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:agro_doctor/pages/homecard/calender.dart';
import 'package:agro_doctor/pages/weather/weather_card.dart';
import 'package:agro_doctor/pages/weather/weather_model.dart';
import 'package:agro_doctor/pages/weather/weather_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../changeLanguage.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _currentIndex = 0;
  late String name;

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
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: _buildTabContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'නිවහන',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'සමජය ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'මාගේ ගිනුම',
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_currentIndex) {
      case 0:
        return HomeTab();
      case 1:
        return CommunityTab();
      case 2:
        return ProfileTab();
      default:
        return Container();
    }
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String displayName = FirebaseAuth.instance.currentUser!.displayName!;
    final String email = FirebaseAuth.instance.currentUser!.email!;
    final String photoUrl = FirebaseAuth.instance.currentUser!.photoURL ?? '';
    return Container(
      color: Colors.white,
      child: Center(
        child: ListView(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: imageSliders,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DismainSin(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Icon(Icons.bug_report),
                        SizedBox(height: 10),
                        Text(
                          'පළිබෝධ සහ රෝග',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 35),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const tips(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Icon(Icons.tips_and_updates),
                        SizedBox(height: 10),
                        Text(
                          'වගා ඉඟි',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 52),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FertilizerCalculator(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Icon(Icons.science),
                        SizedBox(height: 10),
                        Text(
                          'කැල්ක්යුලේටරය',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 35),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "ඔබේ අස්වැන්න සුව කරන්න",
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
                  height: 220.0,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 10,
              child: MaterialButton(
                padding: const EdgeInsets.all(20),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'නව වගාව සඳහා නිර්දේශිත බෝග',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyAppxml()),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const Center(
              child: Text("(Powered by: කෘෂිකර්ම දෙපාර්තමේන්තුව)"),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "රෝග පැතිරීම අනතුරු ඇඟවීම්",
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
                      builder: (context) => MyAppMap(userEmail: email),
                    ),
                  );
                },
                child: Image.asset(
                  'images/spread.png',
                  height: 220.0,
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "කාලගුණය",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                )),
            FutureBuilder<Weather>(
              future: WeatherService.fetchWeatherData('Kiribathgoda'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return WeatherCard(weather: snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WeeklyWeatherScreen()),
                  );
                },
                child: const Text('සතියේ කාලගුණ වාර්තාව'),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 180,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HighlightNewsScreen()));
                      },
                      child: Stack(
                        children: [
                          InkWell(
                            child: Container(
                              width: 170,
                              height: 140,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/card/3.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 20,
                            top: 100,
                            child: Text(
                              "පුවත්",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoteListPage()));
                      },
                      child: Stack(
                        children: [
                          InkWell(
                            child: Container(
                              width: 170,
                              height: 140,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/card/2.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 20,
                            top: 100,
                            child: Text(
                              "Keep Notes",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VegPricePage()));
                      },
                      child: Stack(
                        children: [
                          InkWell(
                            child: Container(
                              width: 170,
                              height: 140,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/card/1.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 20,
                            top: 100,
                            child: Text(
                              "මිල සටහන",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CalendarPageSin()));
                      },
                      child: Stack(
                        children: [
                          InkWell(
                            child: Container(
                              width: 170,
                              height: 140,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/card/1.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 20,
                            top: 100,
                            child: Text(
                              'වගා කැලන්ඩරය',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "වැඩිදුර පුවත්",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('news').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    final data = document.data() as Map<String, dynamic>;
                    final note = data['NoteSin'] ?? '';
                    final topic = data['TopicSin'] ?? '';
                    final image = data['image'] ?? '';

                    return NewsCard(
                      note: note,
                      topic: topic,
                      image: image,
                    );
                  }).toList(),
                );
              },
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HighlightNewsScreen()),
                  );
                },
                child: const Text(
                  'වැඩිදුර පුවත්',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommunityTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text('Community'),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String displayName = FirebaseAuth.instance.currentUser!.displayName!;
    final String email = FirebaseAuth.instance.currentUser!.email!;
    final String photoUrl = FirebaseAuth.instance.currentUser!.photoURL ?? '';
    DateTime currentTime = DateTime.now();
    int currentHour = currentTime.hour;
    bool isMorning = currentHour < 12;
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
            width: 500,
          ),
          Text(
            'සුභ ${isMorning ? "උදෑසනක් " : "සන්දයාවක් " ' $displayName'}',
            style: const TextStyle(fontSize: 20),
          ),
          const Text("සාදරයෙන් පිළිගනිමු Agro Doctor වෙත"),
          const SizedBox(
            height: 20,
            width: 500,
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(photoUrl),
          ),
          Text(
            displayName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            email,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            padding: const EdgeInsets.all(10),
            color: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              'භාෂාව වෙනස් කරන්න',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LanguageSelectionPage()),
              );
            },
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyFormPage(
                        displayName: displayName,
                        photoUrl: photoUrl,
                        email: email,
                      ),
                    ));
              },
              child: const Text('පරිශීලක දත්ත වෙනස් කරන්න'),
            ),
          ),
          GestureDetector(
            onTap: () async {
              const String url = 'https://whatsapp.com/';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 35, bottom: 8, left: 8),
                      child: Image.asset(
                        'images/logoAD.png',
                        width: 50,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Share Agro Doctor',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Share AgroDoctor and help farmers & gardeners to solce their plant probleams.',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => RateAppDialog(),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.star,
                      size: 48,
                      color: Colors.orange,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rate Agro Doctor',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Rate and provide feedback for Agro Doctor.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                ],
              )),
        ))
    .toList();

final List<String> imgList = [
  'images/slide2.png',
  'images/slide1.png',
  'images/slide3.png',
];

class RateAppDialog extends StatefulWidget {
  @override
  _RateAppDialogState createState() => _RateAppDialogState();
}

class _RateAppDialogState extends State<RateAppDialog> {
  int rating = 0;
  String comment = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rate Agro Doctor'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('How would you rate Agro Doctor?'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.star,
                    color: rating >= 1 ? Colors.orange : Colors.grey),
                onPressed: () {
                  setState(() {
                    rating = 1;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.star,
                    color: rating >= 2 ? Colors.orange : Colors.grey),
                onPressed: () {
                  setState(() {
                    rating = 2;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.star,
                    color: rating >= 3 ? Colors.orange : Colors.grey),
                onPressed: () {
                  setState(() {
                    rating = 3;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.star,
                    color: rating >= 4 ? Colors.orange : Colors.grey),
                onPressed: () {
                  setState(() {
                    rating = 4;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.star,
                    color: rating >= 5 ? Colors.orange : Colors.grey),
                onPressed: () {
                  setState(() {
                    rating = 5;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Comment (optional)',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                comment = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Submit'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final String note;
  final String topic;
  final String image;

  const NewsCard({
    super.key,
    required this.note,
    required this.topic,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final String s = image;

    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HighlightNewsScreen()),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topic,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          note,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl: s,
                    width: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
