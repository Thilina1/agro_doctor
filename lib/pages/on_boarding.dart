import 'package:agro_doctor/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

final List<Slide> slides = [
  Slide(
    title: 'Health Check',
    description:
        'Take a picture of your crop to detect diseases and receive treatment advice.',
    backgroundImage: 'images/onboard1.PNG',
    backgroundColor: Colors.blue,
  ),
  Slide(
    title: 'Community',
    description:
        'Ask a question about your crop to receive help from the community.',
    backgroundImage: 'images/onboard2.PNG',
    backgroundColor: Colors.red,
  ),
  Slide(
    title: 'Cultivation Tips',
    description: 'Receive farming advice about how to improve your yield.',
    backgroundImage: 'images/onboard3.PNG',
    backgroundColor: Colors.green,
  ),
];

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      onDonePress: () {
        // Logic to handle "Done" button press
        // For example, navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthService().handleAuthState(),
          ),
        );
      },
    );
  }
}
