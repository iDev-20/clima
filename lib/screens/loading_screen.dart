// ignore_for_file: avoid_print

import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

const apiKey = 'a97768d238ad7ce82199db665e8ac84d';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

//Runs once before the build method
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    getData();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));

      if (response.statusCode == 200) {
        String data = response.body;
        // print(data);

        var decodedData = jsonDecode(data);

        double temperature = decodedData['main']['temp'];
        int conditionId = decodedData['weather'][0]['id'];
        String cityName = decodedData['name'];

        print(temperature);
        print(conditionId);
        print(cityName);
      } else {
        print(response.statusCode);
      }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
