import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherReport {
  final String day;
  final String description;
  final String icon;

  WeatherReport({
    required this.day,
    required this.description,
    required this.icon,
  });
}

class WeeklyWeatherScreen extends StatefulWidget {
  @override
  _WeeklyWeatherScreenState createState() => _WeeklyWeatherScreenState();
}

class _WeeklyWeatherScreenState extends State<WeeklyWeatherScreen> {
  List<WeatherReport> _weatherReports = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    setState(() {
      _isLoading = true;
    });

    const apiKey = 'f1e905d5b6350cc77daf15f150786bf3';
    const apiUrl =
        'https://api.openweathermap.org/data/2.5/forecast?q=Colombo&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> list = responseData['list'];
        final List<WeatherReport> weatherReports = [];

        for (var item in list) {
          final String day = item['dt_txt'];
          final String description = item['weather'][0]['description'];
          final String icon = item['weather'][0]['icon'];

          weatherReports.add(WeatherReport(
            day: day,
            description: description,
            icon: icon,
          ));
        }

        setState(() {
          _weatherReports = weatherReports;
        });
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to fetch weather data check your internet connection.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to connect to the weather service.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        title: const Text(
          'Weekly weather report',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: const <Widget>[],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _weatherReports.length,
              itemBuilder: (ctx, index) {
                final weatherReport = _weatherReports[index];
                return ListTile(
                  leading: Image.network(
                    'https://openweathermap.org/img/w/${weatherReport.icon}.png',
                  ),
                  title: Text(weatherReport.day),
                  subtitle: Text(weatherReport.description),
                );
              },
            ),
    );
  }
}
