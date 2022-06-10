// import 'package:flutter/material.dart';
// import 'package:weather/weather.dart';

// import '../../../flutterFlow/flutter_flow_util.dart';

// class WeatherApi extends ChangeNotifier {
//   String key = '856822fd8e22db5e1ba48c0e7d69844a';
//   late WeatherFactory ws;
//   List<Weather> _data = [];
//   double? lat, lon;
//   DateTime? sunset;
//   var hoursTillSunset;
//   var minutsTillSunset;

//   String? temp;
//   String weatherDescription = "Clear";
//   Image weatherIcon = Image.network(
//     'http://openweathermap.org/img/w/01n.png',
//   );

//   void queryWeather() async {
//     ws = new WeatherFactory(key);

//     Weather weather = await ws.currentWeatherByLocation(-33.948629, 18.431344);
//     _data = [weather];

//     String t = weather.temperature.toString();
//     temp = t.substring(0, t.indexOf('.'));
//     weatherDescription = weather.weatherDescription.toString();
//     var weatherIconCode = weather.weatherIcon!;
//     weatherIcon = Image.network(
//       'http://openweathermap.org/img/w/$weatherIconCode.png',
//     );
//     sunset = weather.sunset;
//     // String formatDate(DateTime date) => new DateFormat("MMMM d").format(sunset!);
//     var hour = sunset?.hour;
//     var minute = sunset?.minute;
//     DateTime date = DateTime.now();
//     var currentHour = date.hour;
//     var currentMinute = date.minute;
//     hoursTillSunset = hour! - currentHour;
//     minutsTillSunset = minute! - currentMinute;

//     notifyListeners();
//   }

//   // void queryForecast() async {
//   //   List<Weather> forecasts =
//   //       await ws.fiveDayForecastByLocation(-33.948629, 18.431344);
//   //   _data = forecasts;
//   //   for (var i = 0; i < forecasts.length; i++) {
//   //     print(forecasts[i]);
//   //   }
//   // }
// }
