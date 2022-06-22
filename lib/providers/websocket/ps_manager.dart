import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/entities/dev_power_summary.dart';
import 'package:provider_test/entities/device_message.dart';
import 'package:provider_test/entities/logger_config.dart';
import 'package:provider_test/entities/power_type.dart';
import 'package:provider_test/providers/websocket/ws_manager.dart';

import '../../screens/profileScreen/profileSettings/electricity_settings.dart';
import '../device_manager.dart';

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
  // double batPower = 0;
  // double batChargeDotActive = 0;
  // double batDischargeDotActive = 0;
  // double batStorage = 0;
  // double batCurrent = 0;
  // double batVoltage = 0;
  // double batRatedPower = 0;
  // double batRatedPowerPercentage = 0;

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
  // double loadChartIconPosition = 0;

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

  bool loader = true;

  var timer;

  Map<String?, List<DevPowerSummary>> get getPowerTypeMap {
    return _powerTypeMap;
  }

  Map<String?, DevPowerSummary> get getLivePowerTypeMap {
    return _livePowerTypeMap;
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

  //This is called after power types are recieved, only once on page load.
  void init(BuildContext context) async {
    List<PowerType>? powerTypeList = await _getPowerTypes(context);
    // List<DevPowerSummary>? powerList = await _getPowerList(context);
    List<LoggerConfig>? calcPowerList = await _getPowerCalcs(context);
    initCalcPowers(calcPowerList!);

    _powerTypeList = powerTypeList;
    _powerTypeMap.clear();
    for (var i = 0; i < powerTypeList!.length; i++) {
      PowerType pType = powerTypeList[i];
      if (_powerTypeMap[pType.powerType] == null) {
        _powerTypeMap[pType.powerType] = [];
      }
      // for (var j = 0; j < powerList!.length; j++) {
      //   if (powerList[j].powerName == powerTypeList[i].powerName) {
      //     _powerTypeMap[pType.powerType]!.add(powerList[j]);
      //   }
      // }
    }
    if (timer != null) {
      timer.cancel();
    }
    timer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      try {
        requestBcMsg(context);
      } catch (e) {
        debugPrint("COULD NOT REQ BC IN PS_MANAGER");
      }
    });
  }

  void requestBcMsg(BuildContext context) {
    DevMessage webSocketMsg = DevMessage();
    webSocketMsg.instr = "broadcastRequest";
    webSocketMsg.msgType = "devInstruction";
    webSocketMsg.devModel = 12;
    webSocketMsg.devModelId = 12;
    webSocketMsg.loggerSerial =
        Provider.of<DeviceManager>(context, listen: false)
            .getSelectedLogger!
            .serNum;

    Provider.of<WsManager>(context, listen: false).sendWsMessage(webSocketMsg);
  }

  void onPsMessageReceived(Map<String, dynamic> msg, context) {
    DevMessage message = DevMessage.fromJson(msg);
    // List<DevPowerSummary>? powerList = message.messageList;
    List<dynamic>? pList = message.messageList;
    List<DevPowerSummary> powerList = [];
    for (var i = 0; i < pList!.length; i++) {
      powerList.add(DevPowerSummary.fromJson(pList[i]));
    }

    // powerList = powerList!.cast<DevPowerSummary>();

    for (var i = 0; i < powerList.length; i++) {
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
          _livePowerTypeMap[pType.powerType]?.powerW = ((powerList[j].powerW) +
              (_livePowerTypeMap[pType.powerType]?.powerW as double));

          _livePowerTypeMap[pType.powerType]?.ratedPowerW =
              ((powerList[j].ratedPowerW) +
                  (_livePowerTypeMap[pType.powerType]?.ratedPowerW as double));

          _livePowerTypeMap[pType.powerType]?.dailyEnergyWh = ((powerList[j]
                  .dailyEnergyWh) +
              (_livePowerTypeMap[pType.powerType]?.dailyEnergyWh as double));

          _livePowerTypeMap[pType.powerType]?.monthlyEnergyWh = ((powerList[j]
                  .monthlyEnergyWh) +
              (_livePowerTypeMap[pType.powerType]?.monthlyEnergyWh as double));

          _livePowerTypeMap[pType.powerType]?.energyWh =
              ((powerList[j].energyWh) +
                  (_livePowerTypeMap[pType.powerType]?.energyWh as double));

          _livePowerTypeMap[pType.powerType]?.voltageV =
              ((powerList[j].voltageV) +
                  (_livePowerTypeMap[pType.powerType]?.voltageV as double));

          _livePowerTypeMap[pType.powerType]?.currentA =
              ((powerList[j].currentA) +
                  (_livePowerTypeMap[pType.powerType]?.currentA as double));
        }
      }
    }

    calcPowerTotals(context);
  }

  void calcPowerTotals(context) {
    final electricitySettings =
        Provider.of<ElectricitySettings>(context, listen: false);
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

    if (_livePowerTypeMap.isEmpty) {
      loader = true;
    } else {
      loader = false;
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

    //Calc Grid Power
    if (gridConsume > 0 || gridFeed > 0) {
      _livePowerTypeMap['grid'] = DevPowerSummary();
      if (totGrid < 0) {
        _livePowerTypeMap['grid']!.powerW = -totGrid;
        _livePowerTypeMap['grid']!.ratedPowerW =
            _livePowerTypeMap['gridFeed']!.ratedPowerW;
      } else {
        _livePowerTypeMap['grid']!.powerW = totGrid;
        _livePowerTypeMap['grid']!.ratedPowerW =
            _livePowerTypeMap['gridConsume']!.ratedPowerW;
      }
    }

    gridPower = totGrid;
    if (gridPower > 0) {
      gridDotActive = 1;
    } else {
      gridDotActive = 0;
    }

    if (_livePowerTypeMap["stCharge"]?.powerW != null) {}
    if (_livePowerTypeMap["stDischarge"]?.powerW != null) {}

    // var totBat = stCharge - stDischarge;
    // if (totBat > 0) {
    //   batPower += totBat;
    // } else {
    //   batPower -= totBat;
    // }

    // Financial Benefits calculations

    dailyFinancial = pvDailyEnergy * electricitySettings.electricityPrice;
    monthlyFinancial = pvMonthlyEnergy * electricitySettings.electricityPrice;
    totalFinancial = pvTotalEnergy * electricitySettings.electricityPrice;

    // Environmental Benefits calculation
    c02Reduced = ((pvTotalEnergy) * 0.9);
    waterSaved = ((pvTotalEnergy) * 1.35);
    electricCar = ((pvTotalEnergy) * 8.2);

    // Energy Efficiency
    // (total Grid / total load) *100

    energyEfficiency = 100 - ((gridPower / loadPower) * 100);
    if (energyEfficiency.isNaN || energyEfficiency < 0) {
      energyEfficiency = 0;
    }
    energyEfficiencyPercentageTxt = energyEfficiency.toStringAsFixed(1);
    energyLinePosition = (energyEfficiency / 100);

    if (energyLinePosition < 0.3) {
      energyEfficiencyColor = Colors.red;
    }
    if (energyLinePosition > 0.3 && energyLinePosition < 0.6) {
      energyEfficiencyColor = Colors.orange;
    }
    if (energyLinePosition > 0.6) {
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

    // if (liveLoadChartPosition > 0.5) {
    //   loadChartIconPosition = maxRange * liveLoadChartPosition;
    // }
    // if (liveLoadChartPosition < 0.5) {
    //   var newPercentageSet = maxRange * liveLoadChartPosition;
    //   loadChartIconPosition = newPercentageSet - minRange;
    // }
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
    }
    return _calcPowerList;
  }

  DevPowerSummary? getExpRecursive(Map<String, dynamic> expMap) {
    DevPowerSummary? p1Value;
    if (expMap['p1'] is String) {
      p1Value = _livePowerMap[expMap['p1']];
    } else if (expMap['p1'] is Map<String, dynamic>) {
      p1Value = getExpRecursive(expMap['p1']);
    } else if (expMap['p1'] is num) {
      p1Value = createEmptyPower();
      p1Value.powerW = expMap['p1'] * 1.0;
    }

    DevPowerSummary? p2Value;
    if (expMap['p2'] is String) {
      p2Value = _livePowerMap[expMap['p2']];
    } else if (expMap['p2'] is Map<String, dynamic>) {
      p2Value = getExpRecursive(expMap['p2']);
    } else if (expMap['p2'] is num) {
      p2Value = createEmptyPower();
      p2Value.powerW = expMap['p2'] * 1.0;
    }

    DevPowerSummary resultPower = createEmptyPower();

    if (p1Value == null || p2Value == null) {
      return resultPower;
    }

    var mathFunction = getMathFunction(expMap['op']);
    resultPower.powerW = mathFunction(p1Value.powerW, p2Value.powerW);
    resultPower.ratedPowerW =
        mathFunction(p1Value.ratedPowerW, p2Value.ratedPowerW);
    resultPower.dailyEnergyWh =
        mathFunction(p1Value.dailyEnergyWh, p2Value.dailyEnergyWh);
    resultPower.energyWh = mathFunction(p1Value.energyWh, p2Value.energyWh);
    resultPower.voltageV = (p1Value.voltageV + p2Value.voltageV) / 2;
    resultPower.currentA = mathFunction(p1Value.currentA, p2Value.currentA);
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
