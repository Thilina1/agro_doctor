import 'dart:ui';
import 'package:agro_doctor/auth/home_page.dart';
import 'package:agro_doctor/auth/sinhala/home_page.dart';
import 'package:flutter/material.dart';

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/icon/selectlan.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(0, 11, 156, 6),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.80),
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Row(
                      children: [
                        Image.asset(
                          'images/icon/logo.png',
                          width: 50,
                        ),
                        const Text(
                          'Hello!',
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Color.fromARGB(255, 32, 31, 31),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Language Selection',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'සාදරයෙන් පිළිගනිමු Agro Doctor වෙත ',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'භාෂාව පහලින් තෝරන්න',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Welcome to Agro Doctor',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Select Language bellow',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      LanguageButton(
                        language: 'English',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                      ),
                      LanguageButton(
                        language: 'සිංහල',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePages()),
                          );
                        },
                      ),
                      LanguageButton(
                        language: 'தமிழ்',
                        onPressed: () {
                          // Handle Tamil button press
                        },
                      ),
                    ],
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

class LanguageButton extends StatelessWidget {
  final String language;
  final VoidCallback onPressed;

  LanguageButton({
    required this.language,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      ),
      child: Text(
        language,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
