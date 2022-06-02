import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/entities/calc_power_expression.dart';
import 'package:provider_test/entities/dev_power_summary.dart';
import 'package:provider_test/entities/device_message.dart';
import 'package:provider_test/entities/logger_config.dart';
import 'package:provider_test/entities/power_type.dart';

import '../../screens/dashboardScreen/dashboardAnimation/dashboard_animation_provider.dart';

class PowerServiceManager extends ChangeNotifier {
  //<powerType, <powerList>>
  final Map<String?, List<DevPowerSummary>> _powerTypeMap = {};
  final Map<String?, DevPowerSummary> _livePowerTypeMap = {};
  final Map<String?, DevPowerSummary> _livePowerMap = {};

  final List<DevPowerSummary> _calcPowerList = [];
  final Map<String?, String?> _expressionPowerMap = {};
  final Map<String?, DevPowerSummary?> _calcPowerMap = {};

  List<PowerType>? _powerTypeList = [];

  // Battery
  double batPower = 0;
  double batChargeDotActive = 0;
  double batDischargeDotActive = 0;
  double batStorage = 0;
  double batCurrent = 0;
  double batVoltage = 0;
  double batRatedPower = 0;
  double batRatedPowerPercentage = 0;

  // GRID
  double gridPower = 0;
  double gridDotActive = 0;
  double gridDailyEnergy = 0;
  double gridRatedPower = 0;
  double gridRatedPowerPercentageLevel = 0;
  double gridVoltage = 0;
  double gridCurrent = 0;
  double gridMonthlyEnergy = 0;
  double gridTotalEnergy = 0;

  // PV
  double pvPower = 0;
  double pvRatedPower = 0;
  double pvRatedPowerPercentageLevel = 0;
  double pvDailyEnergy = 0;
  double pvMonthlyEnergy = 0;
  double pvTotalEnergy = 0;
  double pvToBatDotActive = 0;
  double pvVoltage = 0;
  double pvCurrent = 0;
  double pvAvailable = 0;
  double pvChartIconPosition = 0;
  double pvIconPositionOpacity = 1;
  Color pvIconColor = Colors.green;

// LOAD
  double loadPower = 0;
  double loadDotActive = 0;
  double loadDailyEnergy = 0;
  double loadMonthlyEnergy = 0;
  double loadTotalEnergy = 0;
  double loadRatedPower = 0;
  double loadRatedPowerPercentageLevel = 0;
  double loadVoltage = 0;
  double loadCurrent = 0;
  double loadChartIconPosition = 0;

  // Financial Benefits
  double dailyFinancial = 0;
  double monthlyFinancial = 0;
  double totalFinancial = 0;

  // Enviromental Benefits
  double c02Reduced = 0;
  double waterSaved = 0;
  double electricCar = 0;

  // Energy Efficiency
  String energyEfficiencyPercentageTxt = "0";
  double energyEfficiency = 0;
  double energyLinePosition = 0;
  Color energyEfficiencyColor = Colors.red;

  Map<String?, List<DevPowerSummary>> get getPowerTypeMap {
    return _powerTypeMap;
  }

  Future<List<PowerType>?> _getPowerTypes(BuildContext context) async {
    var powerTypes = await Provider.of<ApiController>(context, listen: false)
        .getPowerTypeList();
    return powerTypes;
  }

  Future<List<DevPowerSummary>?> _getPowerList(BuildContext context) async {
    var powerTypes =
        await Provider.of<ApiController>(context, listen: false).getPowerList();
    return powerTypes;
  }

  Future<List<LoggerConfig>?> _getPowerCalcs(BuildContext context) async {
    var powerCalcs = await Provider.of<ApiController>(context, listen: false)
        .getPowerCalcs();
    return powerCalcs;
  }

  Future<List?> _getLoggerList(BuildContext context) async {
    var powerTypes =
        await Provider.of<ApiController>(context, listen: false).getPowerList();
    return powerTypes;
  }

  //This is called after power types are recieved, only once on page load.
  void init(BuildContext context) async {
    List<PowerType>? powerTypeList = await _getPowerTypes(context);
    List<DevPowerSummary>? powerList = await _getPowerList(context);
    List<LoggerConfig>? calcPowerList = await _getPowerCalcs(context);
    initCalcPowers(calcPowerList!);

    _powerTypeList = powerTypeList;
    for (var i = 0; i < powerTypeList!.length; i++) {
      PowerType pType = powerTypeList[i];
      if (_powerTypeMap[pType.powerType] == null) {
        _powerTypeMap[pType.powerType] = [];
      }
      for (var j = 0; j < powerList!.length; j++) {
        if (powerList[j].powerName == powerTypeList[i].powerName) {
          _powerTypeMap[pType.powerType]!.add(powerList[j]);
        }
      }
    }
  }

  void onEnergyStorageMessageReceived(Map<String, dynamic> msg) {
    if (msg['messageList'].length > 0) {
      batStorage = (msg['messageList'][0]['capacityP']);
      batPower = (msg['messageList'][0]['powerW']) / 1000;
      batCurrent = (msg['messageList'][0]['currentA']);
      batVoltage = (msg['messageList'][0]['voltageV']);

      double ratedCapacityAh = 0;
      double ratedChargeCurrentC = 0;
      double ratedVoltageV = 0;
      ratedCapacityAh += ((msg['messageList'][0]['ratedCapacityAh']));
      ratedChargeCurrentC += ((msg['messageList'][0]['ratedChargeCurrentC']));
      ratedVoltageV += ((msg['messageList'][0]['ratedVoltageV']));

      batRatedPower = ratedCapacityAh * ratedChargeCurrentC * ratedVoltageV;
      batRatedPowerPercentage = ((batPower / batRatedPower) * 100);
      if (batRatedPowerPercentage < 0) {
        batRatedPowerPercentage = 0;
      }
      // Battery
      // double stCharge = 0;
      // if (_livePowerTypeMap["stCharge"]?.powerW != null) {
      //   stCharge = _livePowerTypeMap["stCharge"]?.powerW as double;
      // }
      // double stDischarge = 0;
      // if (_livePowerTypeMap["stDischarge"]?.powerW != null) {
      //   stDischarge = _livePowerTypeMap["stDischarge"]?.powerW as double;
      // }

      // var totBat = stCharge - stDischarge;
      // _batPower = totBat;
      if (batPower > 0) {
        batChargeDotActive = 1;
      } else {
        batChargeDotActive = 0;
      }

      if (batPower < 0) {
        batDischargeDotActive = 1;
      } else {
        batDischargeDotActive = 0;
      }
    }

    // for (var j = 0; j < storageList!.length; j++) {
    // }
  }

  void onPsMessageReceived(Map<String, dynamic> msg) {
    DevMessage message = DevMessage.fromJson(msg);
    List<DevPowerSummary>? powerList = message.messageList;

    for (var i = 0; i < powerList!.length; i++) {
      _livePowerMap[powerList[i].powerName] = powerList[i];
    }

    calcExpressionPowers();
    powerList.addAll(_calcPowerList);

    _livePowerTypeMap.clear();
    for (var i = 0; i < _powerTypeList!.length; i++) {
      PowerType pType = _powerTypeList![i];
      if (_livePowerTypeMap[pType.powerType] == null) {
        _livePowerTypeMap[pType.powerType] = createEmptyPower();
      }

      for (var j = 0; j < powerList.length; j++) {
        if (powerList[j].powerName == pType.powerName) {
          _livePowerTypeMap[pType.powerType]?.powerW =
              ((powerList[j].powerW as double) +
                  (_livePowerTypeMap[pType.powerType]?.powerW as double));

          _livePowerTypeMap[pType.powerType]?.ratedPowerW =
              ((powerList[j].ratedPowerW as double) +
                  (_livePowerTypeMap[pType.powerType]?.ratedPowerW as double));

          _livePowerTypeMap[pType.powerType]?.dailyEnergyWh = ((powerList[j]
                  .dailyEnergyWh as double) +
              (_livePowerTypeMap[pType.powerType]?.dailyEnergyWh as double));

          _livePowerTypeMap[pType.powerType]?.monthlyEnergyWh = ((powerList[j]
                  .monthlyEnergyWh as double) +
              (_livePowerTypeMap[pType.powerType]?.monthlyEnergyWh as double));

          _livePowerTypeMap[pType.powerType]?.energyWh =
              ((powerList[j].energyWh as double) +
                  (_livePowerTypeMap[pType.powerType]?.energyWh as double));

          _livePowerTypeMap[pType.powerType]?.voltageV =
              ((powerList[j].voltageV as double) +
                  (_livePowerTypeMap[pType.powerType]?.voltageV as double));

          _livePowerTypeMap[pType.powerType]?.currentA =
              ((powerList[j].currentA as double) +
                  (_livePowerTypeMap[pType.powerType]?.currentA as double));
        }
      }
    }

    calcPowerTotals();
  }

  void calcPowerTotals() {
    // PV
    if (_livePowerTypeMap["pv"]?.powerW != null) {
      pvPower = _livePowerTypeMap["pv"]?.powerW as double;
      pvRatedPower = _livePowerTypeMap["pv"]?.ratedPowerW as double;
      pvDailyEnergy = (_livePowerTypeMap["pv"]?.dailyEnergyWh as double) / 1000;
      pvMonthlyEnergy =
          (_livePowerTypeMap["pv"]?.monthlyEnergyWh as double) / 1000;
      pvTotalEnergy = (_livePowerTypeMap["pv"]?.energyWh as double) / 1000;
      pvRatedPowerPercentageLevel = ((pvPower / pvRatedPower) * 100);
      if (pvRatedPowerPercentageLevel.isNaN) {
        pvRatedPowerPercentageLevel = 0;
      }
      if (pvRatedPowerPercentageLevel > 100) {
        pvRatedPowerPercentageLevel = 100;
      }
      pvVoltage = _livePowerTypeMap["pv"]?.voltageV as double;
      pvCurrent = _livePowerTypeMap["pv"]?.currentA as double;
    }
    if (pvPower > 0) {
      pvToBatDotActive = 1;
    } else {
      pvToBatDotActive = 0;
    }

    // LOAD
    if (_livePowerTypeMap["load"]?.powerW != null) {
      loadPower = _livePowerTypeMap["load"]?.powerW as double;
      loadDailyEnergy =
          (_livePowerTypeMap["load"]?.dailyEnergyWh as double) / 1000;
      loadRatedPower = _livePowerTypeMap["load"]?.ratedPowerW as double;
      loadRatedPowerPercentageLevel = ((loadPower / loadRatedPower) * 100);
      loadMonthlyEnergy =
          (_livePowerTypeMap["load"]?.monthlyEnergyWh as double) / 1000;
      loadTotalEnergy =
          (_livePowerTypeMap["load"]?.energyWh as double) / 1000000;
      loadVoltage = _livePowerTypeMap["load"]?.voltageV as double;
      loadCurrent = _livePowerTypeMap["load"]?.currentA as double;
      if (loadRatedPowerPercentageLevel.isNaN) {
        loadRatedPowerPercentageLevel = 0;
      }
      if (loadRatedPowerPercentageLevel > 100) {
        loadRatedPowerPercentageLevel = 100;
      }
    }
    if (loadPower > 0) {
      loadDotActive = 1;
    } else {
      loadDotActive = 0;
    }

    //GRID
    double gridFeed = 0;
    if (_livePowerTypeMap["gridFeed"]?.powerW != null) {
      gridFeed = _livePowerTypeMap["gridFeed"]?.powerW as double;
    }
    double gridConsume = 0;
    if (_livePowerTypeMap["gridConsume"]?.powerW != null) {
      gridConsume = _livePowerTypeMap["gridConsume"]?.powerW as double;
      gridDailyEnergy =
          (_livePowerTypeMap["gridConsume"]?.dailyEnergyWh as double) / 1000;
      gridRatedPower = _livePowerTypeMap["gridConsume"]?.ratedPowerW as double;
      gridRatedPowerPercentageLevel = ((gridConsume / gridRatedPower) * 100);
      gridTotalEnergy =
          (_livePowerTypeMap["gridConsume"]?.energyWh as double) / 1000000;
      gridMonthlyEnergy =
          (_livePowerTypeMap["gridConsume"]?.monthlyEnergyWh as double) / 1000;
      gridCurrent = _livePowerTypeMap["gridConsume"]?.currentA as double;
      gridVoltage = _livePowerTypeMap["gridConsume"]?.voltageV as double;
      if (gridRatedPowerPercentageLevel.isNaN) {
        gridRatedPowerPercentageLevel = 0;
      }
      if (gridRatedPowerPercentageLevel > 100) {
        gridRatedPowerPercentageLevel = 100;
      }
    }

    var totGrid = gridConsume - gridFeed;
    gridPower = totGrid;
    if (gridPower > 0) {
      gridDotActive = 1;
    } else {
      gridDotActive = 0;
    }

    // Financial Benefits calculations
    dailyFinancial = pvDailyEnergy * 1.46;
    monthlyFinancial = pvMonthlyEnergy * 1.46;
    totalFinancial = pvTotalEnergy * 1.46;

    // Environmental Benefits calculation
    c02Reduced = ((pvTotalEnergy / 1000000) * 0.9) * 1000;
    waterSaved = ((pvTotalEnergy / 1000000) * 1.35) * 1000;
    electricCar = ((pvTotalEnergy / 1000000) * 8.2) * 1000;

    // Energy Efficiency
    // (total Grid / total load) *100

    energyEfficiency = 100 - ((gridTotalEnergy / loadTotalEnergy) * 100);
    if (energyEfficiency.isNaN) {
      energyEfficiency = 0;
    }
    energyEfficiencyPercentageTxt = energyEfficiency.toStringAsFixed(1);
    energyLinePosition = (energyEfficiency / 100) * 300;

    if (energyLinePosition < 100) {
      energyEfficiencyColor = Colors.red;
    }
    if (energyLinePosition > 100 && energyLinePosition < 200) {
      energyEfficiencyColor = Colors.orange;
    }
    if (energyLinePosition > 200) {
      energyEfficiencyColor = Colors.green;
    }

    // PVChartIconPosition
    List highestRatedPower = [pvRatedPower, loadRatedPower, gridRatedPower];
    var maxY =
        highestRatedPower.reduce((curr, next) => curr > next ? curr : next);
    double maxRange = 40;
    double minRange = 25;
    var livePvChartPosition = pvPower / maxY;
    var liveLoadChartPosition = loadPower / maxY;

    if (livePvChartPosition > 0.5) {
      pvChartIconPosition = maxRange * livePvChartPosition;
    }
    if (livePvChartPosition < 0.5) {
      var newPercentageSet = maxRange * livePvChartPosition;
      pvChartIconPosition = newPercentageSet - minRange;
      if (livePvChartPosition == 0) {
        pvIconPositionOpacity = 0.5;
        pvIconColor = Colors.grey;
      }
    }

    if (liveLoadChartPosition > 0.5) {
      loadChartIconPosition = maxRange * liveLoadChartPosition;
    }
    if (liveLoadChartPosition < 0.5) {
      var newPercentageSet = maxRange * liveLoadChartPosition;
      loadChartIconPosition = newPercentageSet - minRange;
    }
    notifyListeners();
  }

  void initCalcPowers(List<LoggerConfig?> calcPowerList) {
    for (var i = 0; i < calcPowerList.length; i++) {
      DevPowerSummary power = createEmptyPower();
      power.powerName = calcPowerList[i]?.confKey;

      // _calcPowerList.add(power); //not used yet
      _calcPowerMap[power.powerName] = power;
      _expressionPowerMap[power.powerName] = (calcPowerList[i]?.confValue);
    }
  }

  List<DevPowerSummary> calcExpressionPowers() {
    _calcPowerList.clear();
    for (var item in _expressionPowerMap.entries) {
      String? powerName = item.key;
      String? expression = item.value;

      _calcPowerMap[powerName]!.powerName = powerName;
      // _calcPowerMap[powerName]!.powerType = powerName;

      Map<String, dynamic> expMap = jsonDecode(expression!);
      _calcPowerMap[powerName] = getExpRecursive(expMap);
      _calcPowerMap[powerName]!.powerType = expMap['powerType'];
      _calcPowerMap[powerName]!.powerName = powerName;
      _calcPowerList.add(_calcPowerMap[powerName]!);
      debugPrint(_calcPowerMap[powerName]!.powerW.toString());
    }
    return _calcPowerList;
  }

  DevPowerSummary? getExpRecursive(Map<String, dynamic> expMap) {
    var p1Value = null;
    if (expMap['p1'] is String) {
      p1Value = _livePowerMap[expMap['p1']];
    } else if (expMap['p1'] is Map<String, dynamic>) {
      p1Value = getExpRecursive(expMap['p1']);
    } else if (expMap['p1'] is num) {
      p1Value = createEmptyPower();
      p1Value.powerW = expMap['p1'] * 1.0;
    }

    var p2Value = null;
    if (expMap['p2'] is String) {
      p2Value = _livePowerMap[expMap['p2']];
    } else if (expMap['p2'] is Map<String, dynamic>) {
      p2Value = getExpRecursive(expMap['p2']);
    } else if (expMap['p2'] is num) {
      p2Value = createEmptyPower();
      p2Value.powerW = expMap['p2'] * 1.0;
    }

    DevPowerSummary resultPower = createEmptyPower();

    var mathFunction = getMathFunction(expMap['op']);
    resultPower.powerW = mathFunction(p1Value.powerW!, p2Value.powerW!);
    resultPower.ratedPowerW =
        mathFunction(p1Value.ratedPowerW!, p2Value.ratedPowerW!);
    resultPower.dailyEnergyWh =
        mathFunction(p1Value.dailyEnergyWh!, p2Value.dailyEnergyWh!);
    resultPower.energyWh = mathFunction(p1Value.energyWh!, p2Value.energyWh!);
    resultPower.voltageV = mathFunction(p1Value.voltageV!, p2Value.voltageV!);
    resultPower.currentA = mathFunction(p1Value.currentA!, p2Value.currentA!);
    return resultPower;
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
}
