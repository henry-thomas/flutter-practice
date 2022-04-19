import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/entities/dev_power_summary.dart';
import 'package:provider_test/entities/device_message.dart';
import 'package:provider_test/entities/power_type.dart';

class PowerServiceManager extends ChangeNotifier {
  //<powerType, <powerList>>
  Map<String?, List<DevPowerSummary>> powerTypeMap = new HashMap();

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
    if (powerTypeList != null) {
      for (var i = 0; i < powerTypeList.length; i++) {
        PowerType pType = powerTypeList[i];
        if (powerTypeMap[pType.powerType] == null) {
          powerTypeMap[pType.powerType] = [];
        }

        // for(var j = 0; )
      }
    }
    print(powerTypeMap);
  }

  void onPsMessageReceived(Map<String, dynamic> msg) {
    DevMessage message = DevMessage.fromJson(msg);
    List<DevPowerSummary>? powerList = message.messageList;

    if (powerList != null) {
      for (var i = 0; i < powerList.length; i++) {
        String? powerType = powerList[i].powerType;

        if (powerType != null) {
          if (!powerTypeMap.containsKey(powerType)) {
            Map<String?, List<DevPowerSummary>> entry = {powerType: []};
            powerTypeMap.addAll(entry);
          }
          powerTypeMap[powerType]?.add(powerList[i]);
        }
      }
    }
  }
}
