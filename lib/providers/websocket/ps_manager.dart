import 'dart:collection';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/entities/dev_power_summary.dart';
import 'package:provider_test/entities/device_message.dart';
import 'package:provider_test/entities/power_type.dart';

import '../../screens/dashboardScreen/dashboardAnimation/dashboard_animation_provider.dart';

class PowerServiceManager extends ChangeNotifier {
  //<powerType, <powerList>>
  final Map<String?, List<DevPowerSummary>> _powerTypeMap = HashMap();
  final Map<String?, DevPowerSummary> _livePowerTypeMap = HashMap();
  List<PowerType>? _powerTypeList = [];

  double _batPower = 0;
  double _gridPower = 0;

  // PV
  double _pvPower = 0;
  double pvToBatDotActive = 0;


  final DevPowerSummary _loadPower = DevPowerSummary();

  double get getPvPower {
    return _pvPower;
  }

  DevPowerSummary get getLoadPower {
    return _loadPower;
  }

  double get getBatPower {
    return _batPower;
  }

  double get getGridPower {
    return _gridPower;
  }

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


  //This is called after power types are recieved, only once on page load.
  void init(BuildContext context) async {

    List<PowerType>? powerTypeList = await _getPowerTypes(context);
    List<DevPowerSummary>? powerList = await _getPowerList(context);
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

  void onPsMessageReceived(Map<String, dynamic> msg) {
    DevMessage message = DevMessage.fromJson(msg);
    List<DevPowerSummary>? powerList = message.messageList;

    _livePowerTypeMap.clear();
    for (var i = 0; i < _powerTypeList!.length; i++) {
      PowerType pType = _powerTypeList![i];
      if (_livePowerTypeMap[pType.powerType] == null) {
        _livePowerTypeMap[pType.powerType] = new DevPowerSummary();
        _livePowerTypeMap[pType.powerType]!.powerW = 0;
      }

      for (var j = 0; j < powerList!.length; j++) {
        if (powerList[j].powerName == pType.powerName) {

            _livePowerTypeMap[pType.powerType]?.powerW = ((powerList[j].powerW as double) + (_livePowerTypeMap[pType.powerType]?.powerW as double));
            _livePowerTypeMap[pType.powerType]?.ratedPowerW  = ((powerList[j].ratedPowerW as double) + (_livePowerTypeMap[pType.powerType]?.ratedPowerW as double));

        }
      }

    }

    calcPowerTotals();
  }

  void calcPowerTotals() {
    // double totPv = 0;
    debugPrint(_livePowerTypeMap["pv"]?.powerW.toString());
    if(_livePowerTypeMap["pv"]?.powerW !=  null){
    _pvPower = _livePowerTypeMap["pv"]?.powerW  as double;
    }
    if (_pvPower >0) {
      pvToBatDotActive = 1;
    }else {
      pvToBatDotActive = 0;
    }



    debugPrint(_livePowerTypeMap["load"]?.powerW.toString());
    if(_livePowerTypeMap["load"]?.powerW !=  null){
    _loadPower.powerW = _livePowerTypeMap["load"]?.powerW as double ;
    }

    debugPrint(_livePowerTypeMap["gridConsume"]?.powerW.toString());
    debugPrint(_livePowerTypeMap["gridFeed"]?.powerW.toString());

    double gridFeed = 0;
    if(_livePowerTypeMap["gridFeed"]?.powerW !=  null){
      gridFeed = _livePowerTypeMap["gridFeed"]?.powerW as double;
    }
    double gridConsume = 0;
    if(_livePowerTypeMap["gridFeed"]?.powerW !=  null){
      gridConsume = _livePowerTypeMap["gridConsume"]?.powerW as double;
    }

    var totGrid = gridFeed - gridConsume;
      _gridPower = totGrid;

    debugPrint(_livePowerTypeMap["gen"]?.powerW.toString());

    debugPrint(_livePowerTypeMap["stCharge"]?.powerW.toString());
    double stCharge = 0;
    if (_livePowerTypeMap["stCharge"]?.powerW != null) {
      stCharge = _livePowerTypeMap["stCharge"]?.powerW as double;
    }

    debugPrint(_livePowerTypeMap["stDischarge"]?.powerW.toString());
    double stDischarge = 0;
    if (_livePowerTypeMap["stDischarge"]?.powerW !=null) {
      stDischarge = _livePowerTypeMap["stDischarge"]?.powerW as double;
    }

    var totBat = stCharge - stDischarge;
    _batPower = totBat;


    // if (_livePowerTypeMap["pv"] != null) {
    //   for (int i = 0; i < _livePowerTypeMap["pv"]!.length; i++) {
    //     totPv += _powerTypeMap["pv"]![i].powerW as double;
    //   }
    // }
    // _pvPower = totPv;
    // double totLoad = 0;
    // if (_livePowerTypeMap["load"] != null) {
    //   for (int i = 0; i < _powerTypeMap["load"]!.length; i++) {
    //     totLoad += _powerTypeMap["load"]![i].powerW as double;
    //   }
    // }
    // _loadPower = totLoad;
    //
    // double totStCharge = 0;
    // if (_livePowerTypeMap["stCharge"] != null) {
    //   for (int i = 0; i < _powerTypeMap["stCharge"]!.length; i++) {
    //     totStCharge += _powerTypeMap["stCharge"]![i].powerW as double;
    //   }
    // }
    //
    // double totDisCharge = 0;
    // if (_livePowerTypeMap["stDischarge"] != null) {
    //   for (int i = 0; i < _powerTypeMap["stDischarge"]!.length; i++) {
    //     totDisCharge += _powerTypeMap["stDischarge"]![i].powerW as double;
    //   }
    // }
    //
    // if (totStCharge >= totDisCharge) {
    //   _batPower = totStCharge - totDisCharge;
    //   //means bat charging
    // } else {
    //   _batPower = totDisCharge - totStCharge;
    // }
    //
    //
    // double totGridExport = 0;
    // if (_livePowerTypeMap["gridFeed"] != null) {
    //   for (int i = 0; i < _powerTypeMap["gridFeed"]!.length; i++) {
    //     totGridExport += _powerTypeMap["gridFeed"]![i].powerW as double;
    //   }
    // }
    //
    //
    // double totGridImport = 0;
    // if (_livePowerTypeMap["gridConsume"] != null) {
    //   for (int i = 0; i < _powerTypeMap["gridConsume"]!.length; i++) {
    //     totGridImport += _powerTypeMap["gridConsume"]![i].powerW as double;
    //   }
    // }
    //
    //
    // if(totGridImport >= totGridExport){
    //   _gridPower = totGridImport - totGridExport;
    //   //means bat charging
    // }else{
    //   _gridPower = totGridExport - totGridImport;
    // }
    //
    // _gridPower = totGridExport;
    //
    //
    //   double gridImport = 0;
    // if (_livePowerTypeMap["gridConsume"] != null) {
    //   for (int i = 0; i < _powerTypeMap["gridConsume"]!.length; i++) {
    //     gridImport += _powerTypeMap["gridConsume"]![i].powerW as double;
    //     // print("$gridExport this is grid Export");
    //   }
    // }
    //
    //
    //


    notifyListeners();
  }
}
