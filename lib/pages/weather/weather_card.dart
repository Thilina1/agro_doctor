import 'package:agro_doctor/pages/weather/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 210),
            child: Text(
              DateFormat('EEE, MMM d, y').format(DateTime.now()),
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          Row(
            children: [
              const SizedBox(height: 10),
              Text(
                '${weather.temperature.toStringAsFixed(1)}°C',
                style: const TextStyle(fontSize: 35),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 150),
                child: Image.network(
                  'https://openweathermap.org/img/w/${weather.iconCode}.png',
                  width: 50,
                  height: 50,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  weather.condition,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 260),
            child: Text(
              weather.location,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
