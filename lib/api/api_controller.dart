import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_service.dart';
import 'package:provider_test/entities/api_login_response.dart';
import 'package:provider_test/entities/api_response.dart';
import 'package:provider_test/entities/api_response_paginated.dart';
import 'package:provider_test/entities/dev_power_summary.dart';
import 'package:provider_test/entities/energy_storage.dart';
import 'package:provider_test/entities/energy_storage_db.dart';
import 'package:provider_test/entities/logger.dart';
import 'package:provider_test/entities/logger_config.dart';
import 'package:provider_test/providers/device_manager.dart';
import 'package:provider_test/screens/loginScreen/login_components.dart';
import '../entities/power_type.dart';
import 'package:provider_test/screens/dashboardScreen/dashboard_page_view.dart';

import '../naviagation_bar.dart';
import '../screens/profileScreen/profileSettings/electricity_settings.dart';

class ApiController extends ChangeNotifier {
  static const BASE_URL = "http://cweb1.mypower24.co.za/SolarMDApi/";
  // static const BASE_URL = "http://192.168.100.18:8084/SolarMDApi/";
  // static const USERNAME = "kostadin";
  // static const PASSWORD = "1234";
  static const START_DATE = "20220606";
  static const END_DATE = "20220606";
  static const PAGE = 1;
  static const PER_PAGE = 10000;

  static String jwt = "";
  ApiService service = ApiService();

  // void setSelectedLogger(String serNum) {
  //   SELECTED_LOGGER = serNum;
  // }

  Future<List<dynamic>> _getLoggers() async {
    ApiResponsePaginated? response = await service.getLoggers(1, 10000);
    if (response != null) {
      return response.data!["requests"];
    } else {
      return [];
    }
  }

  Future<List<dynamic>?> _getPowerTypes(String serial) async {
    ApiResponse? response = await service.getPowerTypes(serial);
    if (response != null) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> _getPowerList(String serial, String startDate,
      String endDate, int page, int perPage) async {
    ApiResponsePaginated? response =
        await service.getPowerList(serial, startDate, endDate, page, perPage);
    if (response != null) {
      return response.data!["requests"];
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> _getEStorageList(String serial, String startDate,
      String endDate, int page, int perPage) async {
    ApiResponsePaginated? response = await service.getEStorageList(
        serial, startDate, endDate, page, perPage);
    if (response != null) {
      return response.data!["requests"];
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> _getPowerCalcs(String serial) async {
    ApiResponse? response = await service.getPowerCalcs(serial);
    if (response != null) {
      return response.data;
    } else {
      return null;
    }
  }

  void login(String username, String password, BuildContext context) async {
    final electricitySettings = Provider.of<ElectricitySettings>(context, listen: false);
    electricitySettings.setUserName(username);
    ApiLoginResponse? loginResponse =
        await service.sendLoginRequest(username, password);
    if (loginResponse != null) {
      if (loginResponse.success == true) {
        jwt = loginResponse.data?["jwt"];

        await Provider.of<DeviceManager>(context, listen: false).init(context);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return  NavBarPage();
        }));
      }
    } else {
      LoginComponents.errorDialog(context);
      //error "server error"
    }
  }

  Future<List<PowerType>?> getPowerTypeList(String serial) async {
    List<dynamic>? getPowerTypes = await _getPowerTypes(serial);
    List<PowerType> powerTypeList = [];
    if (getPowerTypes != null) {
      for (var i = 0; i < getPowerTypes.length; i++) {
        powerTypeList.add(PowerType.fromJson(getPowerTypes[i]));
      }
    }
    return powerTypeList;
  }

  Future<List<Logger>> getLoggerList() async {
    List<dynamic> getLoggerList = await _getLoggers();
    List<Logger> loggerList = [];
    for (var i = 0; i < getLoggerList.length; i++) {
      loggerList.add(Logger.fromJson(getLoggerList[i]));
    }
    return loggerList;
  }

  Future<List<DevPowerSummary>?> getPowerList(
      String serial, String startDate, String endDate) async {
    List<dynamic>? getPowerList =
        await _getPowerList(serial, startDate, endDate, PAGE, PER_PAGE);
    List<DevPowerSummary> powerList = [];
    if (getPowerList != null) {
      for (var i = 0; i < getPowerList.length; i++) {
        powerList.add(DevPowerSummary.fromJson(getPowerList[i]));
      }
    }
    return powerList;
  }

  Future<List<EnergyStorageDb>?> getEStorageList(
      String serial, String startDate, String endDate) async {
    List<dynamic>? getEStorageList =
        await _getEStorageList(serial, startDate, endDate, PAGE, PER_PAGE);
    List<EnergyStorageDb> eStorageList = [];
    if (getEStorageList != null) {
      for (var i = 0; i < getEStorageList.length; i++) {
        eStorageList.add(EnergyStorageDb.fromJson(getEStorageList[i]));
      }
    }
    return eStorageList;
  }

  Future<List<LoggerConfig>?> getPowerCalcs(String serial) async {
    List<dynamic>? getPowerCalcs = await _getPowerCalcs(serial);
    List<LoggerConfig> powerCalcList = [];
    if (getPowerCalcs != null) {
      for (var i = 0; i < getPowerCalcs.length; i++) {
        powerCalcList.add(LoggerConfig.fromJson(getPowerCalcs[i]));
      }
    }
    return powerCalcList;
  }
}
