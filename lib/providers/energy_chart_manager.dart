import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/entities/dev_power_summary.dart';
import 'package:provider_test/entities/logger.dart';
import 'package:provider_test/flutterFlow/flutter_flow_util.dart';

import '../entities/energy_storage_db.dart';
import '../entities/logger_config.dart';
import '../entities/power_type.dart';
import 'device_manager.dart';

class EnergyChartManager extends ChangeNotifier {
  Map<String, String> periodFormatMap = {
    "daily": "yyyy-MM-dd",
    "weekly": "yyyy-ww",
    "monthly": "yyyy-MM",
    "yearly": "yyyy"
  };

  String selectedPeriod = "daily";

  Map<String, dynamic> _energyMap = {};
  final Map<String?, String?> _expressionPowerMap = {};
  final Map<String?, List<dynamic>> _powerTypeEnergyMap = {};
  final Map<DateTime, List<DevPowerSummary>> _datePowerListMap = {};
  DateTime? selectedDate = DateTime.now();
  String selectedDateStr = "";

  Map<String?, List<dynamic>> get getEnergyTypeMap {
    return _powerTypeEnergyMap;
  }

  Future<Map<String, dynamic>> _getEnergyFromDb(
      BuildContext context, String date, String period) async {
    var energyData = await Provider.of<ApiController>(context, listen: false)
        .getEnergyData(
            Provider.of<DeviceManager>(context, listen: false)
                .getSelectedLogger!
                .serNum,
            date,
            period);
    if (energyData[selectedDateStr] != null) {
      return energyData[selectedDateStr];
    }
    return {};
  }

  Future<List<PowerType>?> _getPowerTypes(BuildContext context) async {
    var powerTypes = await Provider.of<ApiController>(context, listen: false)
        .getPowerTypeList(Provider.of<DeviceManager>(context, listen: false)
            .getSelectedLogger!
            .serNum);
    return powerTypes;
  }

  Future<List<LoggerConfig>?> _getPowerCalcs(BuildContext context) async {
    var powerCalcs = await Provider.of<ApiController>(context, listen: false)
        .getPowerCalcs(Provider.of<DeviceManager>(context, listen: false)
            .getSelectedLogger!
            .serNum);
    return powerCalcs;
  }

  void init(BuildContext context) async {}

  Future<void> getEnergyDataForPeriod(
      BuildContext context, Logger selectedLogger) async {
    if (selectedDate == null) {
      return;
    }

    List<PowerType>? powerTypeList = await _getPowerTypes(context);
    List<LoggerConfig>? calcPowerList = await _getPowerCalcs(context);
    _datePowerListMap.clear();
    initCalcPowers(calcPowerList!);

    DateFormat formatter = DateFormat(periodFormatMap[selectedPeriod]);
    var formattedDate = formatter.format(selectedDate!);
    selectedDateStr = formattedDate;
    formattedDate = '["' + formattedDate + '"]';
    Map<String, dynamic> energyMap =
        await _getEnergyFromDb(context, formattedDate, selectedPeriod);
    _energyMap = energyMap;

    createChartData();

    _powerTypeEnergyMap.clear();

    for (var i = 0; i < powerTypeList!.length; i++) {
      PowerType pType = powerTypeList[i];
      if (_powerTypeEnergyMap[pType.powerType] == null) {
        _powerTypeEnergyMap[pType.powerType] = createEmptyEnergyList();
      }
      _energyMap.forEach((pName, energyValueList) {
        if (pType.powerName == pName) {
          for (var i = 0; i < energyValueList.length; i++) {
            _powerTypeEnergyMap[pType.powerType]![i] += energyValueList[i];
          }
        }
      });
    }
    // alignDates();
    notifyListeners();
  }

  int getPeriodIndex() {
    if (selectedPeriod == "daily") {
      return 0;
    }
    if (selectedPeriod == "weekly") {
      return 1;
    }
    if (selectedPeriod == "monthly") {
      return 2;
    }
    if (selectedPeriod == "yearly") {
      return 3;
    }
    if (selectedPeriod == "total") {
      return 4;
    }
    return 5;
  }

  void createChartData() {
    List<PowerTypeSeriesPoint> ptspList = [];

    _expressionPowerMap.forEach((pName, exp) {
      // _energyMap.forEach((eName, eList) {
      var expRecursive = getExpRecursive(jsonDecode(exp!));
      _energyMap[pName!] = expRecursive;
      // });
    });
  }

  void initCalcPowers(List<LoggerConfig?> calcPowerList) {
    for (var i = 0; i < calcPowerList.length; i++) {
      _expressionPowerMap[calcPowerList[i]?.confKey] =
          (calcPowerList[i]?.confValue);
    }
  }

  List<dynamic> getExpRecursive(Map<String, dynamic> expMap) {
    List<dynamic>? p1Value;
    if (expMap['p1'] is String) {
      p1Value = _energyMap[expMap['p1']];
    } else if (expMap['p1'] is Map<String, dynamic>) {
      p1Value = getExpRecursive(expMap['p1']);
    } else if (expMap['p1'] is num) {
      p1Value = createEmptyEnergyList();
      p1Value[getPeriodIndex()] = expMap['p1'] * 1.0;
    }

    List<dynamic>? p2Value;
    if (expMap['p2'] is String) {
      p2Value = _energyMap[expMap['p2']];
    } else if (expMap['p2'] is Map<String, dynamic>) {
      p2Value = getExpRecursive(expMap['p2']);
    } else if (expMap['p2'] is num) {
      p2Value = createEmptyEnergyList();
      p2Value[getPeriodIndex()] = expMap['p2'] * 1.0;
    }

    List<dynamic> resultPower = createEmptyEnergyList();

    var mathFunction = getMathFunction(expMap['op']);
    if (p1Value == null || p2Value == null) {
      return resultPower;
    }
    resultPower[getPeriodIndex()] =
        mathFunction(p1Value[getPeriodIndex()], p2Value[getPeriodIndex()]);

    return resultPower;
  }

  DevPowerSummary? getPowerFromList(
      List<DevPowerSummary?> pList, String pName) {
    for (var i = 0; i < pList.length; i++) {
      if (pList[i]!.powerName == pName) {
        return pList[i];
      }
    }
    return null;
  }

  double Function(double a, double b) getMathFunction(op) {
    switch (op) {
      case '+':
        return (double a, double b) => a + b;
      case '-':
        return (double a, double b) => a - b;
      case '*':
        return (double a, double b) => a * b;
      case '/':
        return (double a, double b) => a / b;
      default:
        return (double a, double b) => a + b;
    }
  }

  List<dynamic> createEmptyEnergyList() {
    List<dynamic> p = [0.0, 0.0, 0.0, 0.0, 0.0];
    return p;
  }

  Future<DateTime?> onDatePickerOpen(BuildContext context) async {
    selectedDate ??= DateTime.now();
    var dateTime = await showDatePicker(
        context: context,
        initialDate: selectedDate!,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now(),
        helpText: "Query a specific day",
        initialDatePickerMode: DatePickerMode.day);

    selectedDate = dateTime;
    getEnergyDataForPeriod(context,
        Provider.of<DeviceManager>(context, listen: false).getSelectedLogger!);
    return dateTime;
  }
}

class PowerTypeSeriesPoint {
  DateTime time;
  double value;

  PowerTypeSeriesPoint(this.time, this.value);
}
