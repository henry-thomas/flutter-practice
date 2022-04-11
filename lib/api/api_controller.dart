import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider_test/api/api_service.dart';
import 'package:provider_test/entities/api_login_response.dart';
import 'package:provider_test/entities/api_response.dart';

class ApiController extends ChangeNotifier {
  static const BASE_URL = "http://192.168.100.18:8084/SolarMDApi/";
  static const USERNAME = "kostadin";
  static const PASSWORD = "1234";
  static const SELECTED_LOGGER = "MP-1623061258731";

  static String jwt = "";
  ApiService service = ApiService();

  void login(String username, String password) async {
    ApiLoginResponse? loginResponse =
        await service.sendLoginRequest(username, password);
    if (loginResponse != null) {
      if (loginResponse.success == true) {
        jwt = loginResponse.data?["jwt"];
      }
    }

    getPowerTypes();
  }

  Future<List<dynamic>?> getPowerTypes() async {
    ApiResponse? response = await service.sendPowerTypeRequest();
    if (response != null) {
      return response.data;
    } else {
      return null;
    }
  }
}
