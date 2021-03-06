import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/entities/device_message.dart';
import 'package:provider_test/providers/device_manager.dart';
import 'package:provider_test/providers/websocket/es_manager.dart';
import 'package:provider_test/providers/websocket/ps_manager.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WsManager extends ChangeNotifier {
  int requestId = 0;
  bool isInit = false;

  // static String loggerSerial = ApiController.SELECTED_LOGGER;
  static String devModel = "12";
  var channel;

  bool initWs(BuildContext context) {
    String loggerSerial = Provider.of<DeviceManager>(context, listen: false)
        .getSelectedLogger!
        .serNum;
    // String url = 'ws://192.168.100.18:8084/SolarMDApi/mobile?token=' +
    String url = 'ws://cweb1.mypower24.co.za/SolarMDApi/mobile?token=' +
        ApiController.jwt +
        '&loggerSerial=' +
        loggerSerial +
        '&deviceModel=' +
        devModel;

    if (isInit) {
      channel.sink.close();
      isInit = false;
    }

    if (!isInit) {
      channel = WebSocketChannel.connect(Uri.parse(url));
      channel.stream.listen((event) {
        processMessage(jsonDecode(event), context);
      });
      isInit = true;
      return true;
    }

    return false;
  }

  void onConnectionInit(BuildContext context) {
    DevMessage webSocketMsg = DevMessage();
    webSocketMsg.instr = "";
    webSocketMsg.msgType = "conConfig";
    webSocketMsg.devModel = 12;
    webSocketMsg.devModelId = 12;
    webSocketMsg.loggerSerial =
        Provider.of<DeviceManager>(context, listen: false)
            .getSelectedLogger!
            .serNum;

    // _onConnectionInit(context);
    sendWsMessage(webSocketMsg);
  }

  void sendWsMessage(DevMessage webSocketMsg) {
    requestId++;
    webSocketMsg.requestID = requestId;
    var serilizedMsg = webSocketMsg.toJson();
    var encodedWebSocketMsg = jsonEncode(serilizedMsg);
    channel.sink.add(encodedWebSocketMsg);
  }

  void processMessage(Map<String, dynamic> data, BuildContext context) {
    var msgType = data['msgType'];
    switch (msgType) {
      case "connectionInit": //BroadcastData
        // startRandom();
        onConnectionInit(context);
        break;
      case 0: //BroadcastData
        if (data['devModel'] == 12) {
          _processPsMessage(context, data);
        }
        if (data['devModel'] == 11) {
          _processEnergyStorageMessage(context, data);
        }

        break;
      case 1:
        // ResponseMessage
        break;
      case 2: // EventMessage
        break;
      case 3: //Authentication

        break;
      case 4: //DeviceStatus

        break;
      case 5: //DeviceData

        break;
      case 10: //LoggerConnectionStatus

        break;
      default:
    }
  }

  void _processPsMessage(BuildContext context, Map<String, dynamic> msg) {
    Provider.of<PowerServiceManager>(context, listen: false)
        .onPsMessageReceived(msg, context);
  }

  void _processEnergyStorageMessage(
      BuildContext context, Map<String, dynamic> msg) {
    Provider.of<EnergyStorageServiceManager>(context, listen: false)
        .onEnergyStorageMessageReceived(msg);
  }
}
