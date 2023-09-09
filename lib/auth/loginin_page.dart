import 'package:agro_doctor/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wall.png'),
            fit: BoxFit.cover,
          ),
        ),
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: size.height * 0.2,
        ),
        child: Column(
          children: [
            const Text("\nHello, \nWelcome to Agro Doctor",
                style: TextStyle(fontSize: 30, color: Colors.white)),
            const SizedBox(height: 80),
            const Text("\n\nPlease login with your google account",
                style: TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 30),
            GestureDetector(
                onTap: () {
                  AuthService().signInWithGoogle();
                },
                child: const Image(
                    width: 220, image: AssetImage('images/logosign in.png'))),
            const SizedBox(
              height: 250,
            ),
            const Text("Version 1.0",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
