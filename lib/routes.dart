import 'package:agro_doctor/pages/homecard/calender.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String page2 = '/page2';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      page2: (context) => CalendarPage(),
      // Add more routes as needed
    };
  }
}
