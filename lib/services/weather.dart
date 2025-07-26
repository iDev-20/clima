import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/ui_model.dart';

const apiKey = 'a97768d238ad7ce82199db665e8ac84d';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<Weather?> getCityWeather(String cityName) async {
    final url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    final weatherData = await NetworkHelper(url).getData();

    if (weatherData == null) return null;
    return Weather.fromJson(weatherData);
  }

  Future<Weather?> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    final url = '$openWeatherMapURL?'
        'lat=${location.latitude}&lon=${location.longitude}'
        '&appid=$apiKey&units=metric';

    final weatherData = await NetworkHelper(url).getData();

    if (weatherData == null) return null;
    return Weather.fromJson(weatherData);
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
