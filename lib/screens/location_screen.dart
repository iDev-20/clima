// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/navigation.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather});

  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? temperature;
  String? weatherIcon;
  String? cityName;
  String? weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = 'your city';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition ?? 0);

      cityName = weatherData['name'];
      weatherMessage = weather.getMessage(temperature ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        Navigation.navigateToScreen(
                            context: context, screen: const LoadingScreen());
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      style: kButtonStyle,
                      child: const Icon(
                        Icons.near_me,
                        size: 35.0,
                        color: kIconColor,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var typedName = await Navigation.navigateToScreen(
                            context: context, screen: const CityScreen());
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      style: kButtonStyle,
                      child: const Icon(
                        Icons.location_city,
                        size: 35.0,
                        color: kIconColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon ?? '',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
                Text(
                  '$weatherMessage in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
                if (weatherIcon == 'Error')
                  const Text(
                    "Ensure your phone's location is turned on, "
                    "check your internet connection, then try again.",
                    style: kErrorMessageTextStyle,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
