import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/entities/energy_storage.dart';
import 'package:provider_test/providers/websocket/ws_manager.dart';

import '../../entities/device_message.dart';
import '../device_manager.dart';

class EnergyStorageServiceManager extends ChangeNotifier {
  final List<EnergyStorage>? _storageList = [];

  EnergyStorage sumData = EnergyStorage();

  double batChargeDotActive = 0;
  double batDischargeDotActive = 0;

  // ignore: prefer_typing_uninitialized_variables
  var timer;

  void init(BuildContext context) async {
    if (timer != null) {
      timer.cancel();
    }
    _storageList?.clear();
    timer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      try {
        if (Provider.of<DeviceManager>(context, listen: false)
            .getSelectedLogger!
            .connected) {
          requestBcMsg(context);
        } else {
          _storageList!.clear();
          sumData = EnergyStorage();
          batChargeDotActive = 0;
          batDischargeDotActive = 0;
        }
      } catch (e) {
        debugPrint("COULD NOT REQ BC IN ES_MANAGER");
      }
    });
  }

  void onEnergyStorageMessageReceived(Map<String, dynamic> msg) {
    DevMessage message = DevMessage.fromJson(msg);
    List<dynamic>? sList = message.messageList;
    List<EnergyStorage> storageList = [];
    for (var i = 0; i < sList!.length; i++) {
      storageList.add(EnergyStorage.fromJson(sList[i]));
    }

    _storageList!.addAll(storageList);
    calcEStorageTotals(storageList);
  }

  void calcEStorageTotals(List<EnergyStorage> storageList) {
    sumData = EnergyStorage();
    sumData.onlineSt = 0;
    sumData.offlineSt = 0;
    sumData.ratedPowerW = 0;
    for (var i = 0; i < storageList.length; i++) {
      if (storageList[i].available) {
        sumData.available = true;
        sumData.onlineSt = sumData.onlineSt! + 1;
        sumData.powerW += storageList[i].powerW;
        sumData.currentA += storageList[i].currentA;
        sumData.voltageV += storageList[i].voltageV;

        sumData.capacityAh += storageList[i].capacityAh;
        sumData.capacityP += storageList[i].capacityP;
        sumData.ratedCapacityAh += storageList[i].ratedCapacityAh;
        sumData.ratedChargeCurrentC += storageList[i].ratedChargeCurrentC;
        sumData.ratedVoltageV += storageList[i].ratedVoltageV;
        sumData.remainingTimeSign += storageList[i].remainingTimeSign;
      } else {
        sumData.offlineSt = sumData.offlineSt! + 1;
      }
      sumData.storageName += (" " + storageList[i].storageName);
    }

    if (sumData.onlineSt! > 0) {
      if (sumData.onlineSt! > 1) {
        sumData.voltageV /= sumData.onlineSt!;
        sumData.capacityP /= sumData.onlineSt!;
        sumData.ratedVoltageV /= sumData.onlineSt!;
      }
      sumData.powerW = sumData.currentA * sumData.voltageV;
      sumData.ratedPowerW = sumData.ratedChargeCurrentC *
          sumData.ratedCapacityAh *
          sumData.ratedVoltageV;
    }

    if (sumData.powerW > 0) {
      batChargeDotActive = 1;
    } else {
      batChargeDotActive = 0;
    }

    if (sumData.powerW < 0) {
      batDischargeDotActive = 1;
    } else {
      batDischargeDotActive = 0;
    }

    notifyListeners();
  }

  void requestBcMsg(BuildContext context) {
    DevMessage webSocketMsg = DevMessage();
    webSocketMsg.instr = "broadcastRequest";
    webSocketMsg.msgType = "devInstruction";
    webSocketMsg.devModel = 11;
    webSocketMsg.devModelId = 11;
    webSocketMsg.loggerSerial =
        Provider.of<DeviceManager>(context, listen: false)
            .getSelectedLogger!
            .serNum;

    Provider.of<WsManager>(context, listen: false).sendWsMessage(webSocketMsg);
  }
}
