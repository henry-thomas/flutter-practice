import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/entities/dev_power_summary.dart';
import 'package:provider_test/entities/device_message.dart';
import 'package:provider_test/entities/power_type.dart';

class PowerServiceManager extends ChangeNotifier {
  //<powerType, <powerList>>
  final Map<String?, List<DevPowerSummary>> _powerTypeMap = HashMap();
  double _batPower = 0;
  // double _gridPower = 0;
  // double _pvPower = 0;

  // double get getPvPower {
  //   return _pvPower;
  // }

  double get getBatPower {
    return _batPower;
  }
  // double get getGridPower {
  //   return _gridPower;
  // }

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

    if (powerList != null) {
      for (var i = 0; i < powerList.length; i++) {
        String? powerType = powerList[i].powerType;

        if (powerType != null) {
          if (!_powerTypeMap.containsKey(powerType)) {
            Map<String?, List<DevPowerSummary>> entry = {powerType: []};
            _powerTypeMap.addAll(entry);
          }
          _powerTypeMap[powerType]?.add(powerList[i]);
        }
      }

    }

    calcPowerTotals();
  }

  void calcPowerTotals(){


    // double totPv = 0;
    // for(int i = 0; i<_powerTypeMap["pv"]!.length; i++){
    //   totPv += _powerTypeMap["pv"]![i].powerW as double;
    // }
    // if (totPv >0) {
    //   _pvPower = totPv;
    // }


    double totStCharge = 0;
    for(int i = 0; i<_powerTypeMap["stCharge"]!.length; i++){
      totStCharge += _powerTypeMap["stCharge"]![i].powerW as double;
    }

    double totDisCharge = 0;
    for(int i = 0; i<_powerTypeMap["stDischarge"]!.length; i++){
      totStCharge += _powerTypeMap["stDischarge"]![i].powerW as double;
    }

    if(totStCharge >= totDisCharge){
      _batPower = totStCharge - totDisCharge;
      //means bat charging
    }else{
      _batPower = totDisCharge - totStCharge;
    }

    // if (_powerTypeMap["gridImport"]!.length != null) {
    //   double gridImport = 0;
    //   for(int i = 0; i<_powerTypeMap["gridImport"]!.length; i++){
    //     totStCharge += _powerTypeMap["gridImport"]![i].powerW as double;
    //   }
    //
    //   double gridExport = 0;
    //   for(int i = 0; i<_powerTypeMap["gridExport"]!.length; i++){
    //     totStCharge += _powerTypeMap["gridExport"]![i].powerW as double;
    //   }
    //
    //   if(gridImport >= gridExport){
    //     _gridPower = gridImport - gridExport;
    //     //means bat charging
    //   }else{
    //     _gridPower = gridExport - gridImport;
    //   }
    // }



  }
}
