import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_service.dart';
import 'package:provider_test/entities/api_login_response.dart';
import 'package:provider_test/entities/api_response.dart';
import 'package:provider_test/entities/api_response_power.dart';
import 'package:provider_test/entities/dev_power_summary.dart';

import '../entities/power_type.dart';
import '../providers/websocket/ps_manager.dart';

class ApiController extends ChangeNotifier {
  static const BASE_URL = "http://192.168.100.18:8084/SolarMDApi/";
  static const USERNAME = "kostadin";
  static const PASSWORD = "1234";
  static const SELECTED_LOGGER = "SLV209980540";
  static const START_DATE = "20220201";
  static const END_DATE = "20220513";
  static const PAGE = 1;
  static const PER_PAGE = 1000000000000;

  static String jwt = "";
  ApiService service = ApiService();

  Future _initPsManager(BuildContext context) async {
    await Provider.of<PowerServiceManager>(context, listen: false)
        .init(context);
  }

  Future<List<dynamic>?> _getPowerTypes() async {
    ApiResponse? response = await service.getPowerTypes();
    if (response != null) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> _getPowerList(
      String startDate, String endDate, int page, int perPage) async {
    ApiResponsePower? response =
        await service.getPowerList(startDate, endDate, page, perPage);
    if (response != null) {
      return response.data!["requests"];
    } else {
      return null;
    }
  }

  Future login(String username, String password, BuildContext context) async {
    ApiLoginResponse? loginResponse =
        await service.sendLoginRequest(username, password);
    if (loginResponse != null) {
      if (loginResponse.success == true) {
        jwt = loginResponse.data?["jwt"];
        await _initPsManager(context);
      }
    }
  }

  Future<List<PowerType>?> getPowerTypeList() async {
    List<dynamic>? getPowerTypes = await _getPowerTypes();
    List<PowerType> powerTypeList = [];
    if (getPowerTypes != null) {
      for (var i = 0; i < getPowerTypes.length; i++) {
        powerTypeList.add(PowerType.fromJson(getPowerTypes[i]));
      }
    }
    return powerTypeList;
  }

  Future<List<DevPowerSummary>?> getPowerList() async {
    List<dynamic>? getPowerList =
        await _getPowerList(START_DATE, END_DATE, PAGE, PER_PAGE);
    List<DevPowerSummary> powerList = [];
    if (getPowerList != null) {
      for (var i = 0; i < getPowerList.length; i++) {
        powerList.add(DevPowerSummary.fromJson(getPowerList[i]));
      }
    }
    return powerList;
  }
}
