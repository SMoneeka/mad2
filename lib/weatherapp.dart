import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = 'YOUR_API_KEY'; // Replace with your OpenWeatherMap API key

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  String city = "";
  bool isLoading = false;
  Map<String, dynamic>? weatherData;
  String? error;

  Future<void> fetchWeather(String cityName) async {
    setState(() {
      isLoading = true;
      error = null;
    });
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric',
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
        });
      } else {
        setState(() {
          error = 'City not found. Please try again!';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Failed to load weather data.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: "Enter City",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    fetchWeather(_cityController.text.trim());
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : error != null
                    ? Text(error!, style: const TextStyle(color: Colors.red))
                    : weatherData != null
                        ? Column(
                            children: [
                              Text(
                                weatherData!["name"],
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${weatherData!["main"]["temp"]}°C",
                                style: const TextStyle(fontSize: 32),
                              ),
                              Text(weatherData!["weather"][0]["description"]),
                              const SizedBox(height: 10),
                              Image.network(
                                'https://openweathermap.org/img/wn/${weatherData!["weather"][0]["icon"]}@2x.png',
                              ),
                            ],
                          )
                        : const Text("Search for a city to get weather updates."),
          ],
        ),
      ),
    );
  }
}