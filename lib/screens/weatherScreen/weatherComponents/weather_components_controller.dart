

import 'package:flutter/cupertino.dart';
import 'package:provider_test/screens/weatherScreen/weatherComponents/weekly_weather_list_component.dart';

class WeatherUIController {
  List <Widget>  weatherInfoList = [weatherComponents(),weatherComponents(),weatherComponents(),weatherComponents(),weatherComponents(),weatherComponents(),weatherComponents(),];

  void addWeather () {
weatherInfoList.add(weatherComponents());
  }


}