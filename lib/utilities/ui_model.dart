class Weather {
  final double temperature;
  final int weatherId;
  final String cityName;

  Weather(
      {required this.temperature,
      required this.weatherId,
      required this.cityName});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'],
      weatherId: json['weather'][0]['id'],
      cityName: json['name'],
    );
  }
}
