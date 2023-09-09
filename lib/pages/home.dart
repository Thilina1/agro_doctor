import 'package:carousel_slider/carousel_slider.dart';
import 'package:agro_doctor/home_screen.dart';
import 'package:agro_doctor/pages/homecard/calender.dart';
import 'package:agro_doctor/pages/homecard/cultivationtips.dart';
import 'package:agro_doctor/pages/homecard/fertilizerCal.dart';
import 'package:agro_doctor/pages/weather/weather_card.dart';
import 'package:agro_doctor/pages/weather/weather_model.dart';
import 'package:agro_doctor/pages/weather/weather_service.dart';
import 'package:agro_doctor/pages/weather/weeklyreport.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'images/slide2.png',
  'images/slide1.png',
  'images/slide3.png',
];

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agro Doctor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        SettingsPage.routeName: (context) => SettingsPage(),
        ProfilePage.routeName: (context) => ProfilePage(),
        '/page2': (context) => CalendarPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SettingsPage(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: ListView(
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
                    // Add your button onPressed logic here
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Icon(Icons.bug_report), // Icon
                      SizedBox(
                          height:
                              10), // Add some space between the icon and text
                      Text(
                        'Pests & Diseases',
                        style: TextStyle(
                          color: Colors.black, // Set the desired text color
                        ),
                      ),
                      SizedBox(height: 20), // Text
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
                        builder: (context) => const FCalculator(),
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
                      Icon(Icons.science), // Icon
                      SizedBox(
                          height:
                              10), // Add some space between the icon and text
                      Text(
                        'Fertilizer Calculator',
                        style: TextStyle(
                          color: Colors.black, // Set the desired text color
                        ),
                      ),
                      SizedBox(height: 20), // Text
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
                      Icon(Icons.tips_and_updates), // Icon
                      SizedBox(
                          height:
                              10), // Add some space between the icon and text
                      Text(
                        'Cultivation Tips',
                        style: TextStyle(
                          color: Colors.black, // Set the desired text color
                        ),
                      ),
                      SizedBox(height: 20), // Text
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
                "Diseases Spread Alerts",
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
                    builder: (context) => CalendarPage(),
                  ),
                );
              },
              child: Image.asset(
                'images/spread.png',
                height: 220.0, // Path to your image file
              ),
            ),
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
          const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "Weather",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              )),
          FutureBuilder<Weather>(
            future: WeatherService.fetchWeatherData(
                'Kiribathgoda'), // Replace with the desired city name
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
              child: const Text('Weekly weather report'),
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

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Community',
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
      body: const Center(
          child: Row(
        children: [],
      )),
    );
  }
}

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Community',
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
      body: const Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
