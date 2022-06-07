import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/entities/dev_power_summary.dart';
import 'package:provider_test/flutterFlow/flutter_flow_util.dart';

import '../entities/logger_config.dart';
import '../entities/power_type.dart';
import 'device_manager.dart';

class PowerTypeChartDataManager extends ChangeNotifier {
  List<DevPowerSummary>? _powerList = [];
  final Map<String?, String?> _expressionPowerMap = {};
  final Map<String?, List<DevPowerSummary>> _powerTypeMap = {};
  final Map<String?, List<DevPowerSummary>> _powerMap = {};
  final Map<DateTime, List<DevPowerSummary>> _datePowerListMap = {};
  DateTime? selectedDate = DateTime.now();
  String selectedDateStr = "";

  Map<String?, List<DevPowerSummary>> get getPowerTypeMap {
    return _powerTypeMap;
  }

  Future<List<DevPowerSummary>?> _getPowerList(
      BuildContext context, String startDatem, String endDate) async {
    var powerTypes = await Provider.of<ApiController>(context, listen: false)
        .getPowerList(
            Provider.of<DeviceManager>(context, listen: false)
                .getSelectedLogger!
                .serNum,
            startDatem,
            endDate);
    return powerTypes;
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

  Future<void> getPowerTypesFromDateRange(BuildContext context) async {
    List<PowerType>? powerTypeList = await _getPowerTypes(context);
    List<LoggerConfig>? calcPowerList = await _getPowerCalcs(context);
    _datePowerListMap.clear();
    initCalcPowers(calcPowerList!);

    DateFormat df = DateFormat("yyyy-MMMM-dd");
    selectedDateStr = df.format(selectedDate!);

    DateFormat formatter = DateFormat('yyyyMMdd');
    String sDate = formatter.format(selectedDate!);
    String eDate = formatter.format(selectedDate!);

    List<DevPowerSummary>? powerList =
        await _getPowerList(context, sDate, eDate);

    _powerList = powerList;

    createChartData();

    // var calcExpPowers = calcExpressionPowers(powerList);

    _powerTypeMap.clear();
    for (var i = 0; i < powerTypeList!.length; i++) {
      PowerType pType = powerTypeList[i];
      if (_powerTypeMap[pType.powerType] == null) {
        _powerTypeMap[pType.powerType] = [];
      }
      for (var j = 0; j < _powerList!.length; j++) {
        if (_powerMap[_powerList![j].powerName] == null) {
          _powerMap[_powerList![j].powerName] = [];
        }

        if (_powerList![j].powerName == powerTypeList[i].powerName) {
          _powerTypeMap[pType.powerType]!.add(_powerList![j]);
        }
      }
    }

    notifyListeners();
  }

  void createChartData() {
    // List<PowerTypeSeriesPoint> ptspList = [];
    for (var i = 0; i < _powerList!.length; i++) {
      if (!_datePowerListMap.containsKey(
          DateTime.fromMillisecondsSinceEpoch(_powerList![i].lastUpdate))) {
        _datePowerListMap[DateTime.fromMillisecondsSinceEpoch(
            _powerList![i].lastUpdate)] = [];
      }
      _datePowerListMap[
              DateTime.fromMillisecondsSinceEpoch(_powerList![i].lastUpdate)]!
          .add(_powerList![i]);
    }

    _expressionPowerMap.forEach((pName, exp) {
      _datePowerListMap.forEach((date, pList) {
        var expRecursive = getExpRecursive(jsonDecode(exp!), date);
        if (expRecursive != null) {
          expRecursive.powerName = pName;
          _powerList!.add(expRecursive);
        }
      });
    });
  }

  void initCalcPowers(List<LoggerConfig?> calcPowerList) {
    for (var i = 0; i < calcPowerList.length; i++) {
      _expressionPowerMap[calcPowerList[i]?.confKey] =
          (calcPowerList[i]?.confValue);
    }
  }

  DevPowerSummary? getExpRecursive(Map<String, dynamic> expMap, DateTime date) {
    var p1Value = null;
    if (expMap['p1'] is String) {
      p1Value = getPowerFromList(_datePowerListMap[date]!, expMap['p1']);
    } else if (expMap['p1'] is Map<String, dynamic>) {
      p1Value = getExpRecursive(expMap['p1'], date);
    } else if (expMap['p1'] is num) {
      p1Value = createEmptyPower();
      p1Value.powerW = expMap['p1'] * 1.0;
    }

    var p2Value = null;
    if (expMap['p2'] is String) {
      p2Value = getPowerFromList(_datePowerListMap[date]!, expMap['p2']);
    } else if (expMap['p2'] is Map<String, dynamic>) {
      p2Value = getExpRecursive(expMap['p2'], date);
    } else if (expMap['p2'] is num) {
      p2Value = createEmptyPower();
      p2Value.powerW = expMap['p2'] * 1.0;
    }

    DevPowerSummary? resultPower = createEmptyPower();

    resultPower.lastUpdate = date.millisecondsSinceEpoch;

    var mathFunction = getMathFunction(expMap['op']);
    if (p1Value == null || p2Value == null) {
      return resultPower;
    }
    resultPower.powerW = mathFunction(p1Value.powerW!, p2Value.powerW!);
    resultPower.ratedPowerW =
        mathFunction(p1Value.ratedPowerW!, p2Value.ratedPowerW!);
    resultPower.dailyEnergyWh =
        mathFunction(p1Value.dailyEnergyWh!, p2Value.dailyEnergyWh!);
    resultPower.energyWh = mathFunction(p1Value.energyWh!, p2Value.energyWh!);
    resultPower.voltageV = (p1Value.voltageV! + p2Value.voltageV!) / 2;
    resultPower.currentA = mathFunction(p1Value.currentA!, p2Value.currentA!);
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

  DevPowerSummary createEmptyPower() {
    DevPowerSummary p = DevPowerSummary();
    p.powerW = 0;
    p.ratedPowerW = 0;
    p.dailyEnergyWh = 0;
    p.monthlyEnergyWh = 0;
    p.energyWh = 0;
    p.voltageV = 0;
    p.currentA = 0;
    return p;
  }

  Future<DateTime?> onDatePickerOpen(BuildContext context) async {
    var dateTime = await showDatePicker(
        context: context,
        initialDate: selectedDate!,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now(),
        helpText: "Query a specific day",
        initialDatePickerMode: DatePickerMode.day);

    selectedDate = dateTime;
    return dateTime;
  }
}

class PowerTypeSeriesPoint {
  DateTime time;
  double value;

  PowerTypeSeriesPoint(this.time, this.value);
}
