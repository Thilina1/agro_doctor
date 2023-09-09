import 'dart:convert';
import 'package:agro_doctor/pages/weather/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const apiKey = 'f1e905d5b6350cc77daf15f150786bf3';
  static const baseUrl = 'https://api.openweathermap.org/data/2.5';

  static Future<Weather> fetchWeatherData(String cityName) async {
    final url =
        Uri.parse('$baseUrl/weather?q=$cityName&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return Weather(
        location: data['name'],
        temperature: data['main']['temp'].toDouble(),
        condition: data['weather'][0]['main'],
        iconCode: data['weather'][0]['icon'],
      );
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
