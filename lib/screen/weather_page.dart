import 'package:flutter/material.dart';
import 'package:treetaskfocus/screen/weather_service.dart';
import 'package:treetaskfocus/screen/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _WeatherService = WeatherService('5cea55e44a57358a71b7835a21225eed');
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather(); // เรียกใช้งาน method ที่นี่
  }

  _fetchWeather() async {
    String cityName = "Nakhon Pathom";

    try {
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather: $e'); // แสดง error ใน console
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ??
                "Loading city..."), // ถ้าข้อมูลมีค่าก็ควรแสดงชื่อเมือง
            Text(_weather != null
                ? '${_weather!.temperature.round().toString()}°C'
                : 'Loading weather...'), // ถ้า temperature มีค่าก็ควรแสดงอุณหภูมิ
          ],
        ),
      ),
    );
  }
}
