import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/api/api_service.dart';
import 'package:provider_test/entities/device_message.dart';
import 'package:provider_test/main.dart';
import 'package:provider_test/providers/websocket/ps_manager.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WsManager extends ChangeNotifier {
  var _count = 0;
  var _random = 0;
  int requestId = 0;

  int get getRandom {
    return _random;
  }

  int get getCounter {
    return _count;
  }

  void requestBcMsg(channel) {
    DevMessage webSocketMsg = DevMessage();
    webSocketMsg.instr = "broadcastRequest";
    webSocketMsg.msgType = "devInstruction";
    webSocketMsg.devModel = 12;
    webSocketMsg.devModelId = 12;
    webSocketMsg.loggerSerial = MyHomePage.loggerSerial;

    sendWsMessage(webSocketMsg, channel);
  }

  void onConnectionInit(channel) {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      requestBcMsg(channel);
    });

    DevMessage webSocketMsg = DevMessage();
    webSocketMsg.instr = "";
    webSocketMsg.msgType = "conConfig";
    webSocketMsg.devModel = 12;
    webSocketMsg.devModelId = 12;
    webSocketMsg.loggerSerial = MyHomePage.loggerSerial;

    sendWsMessage(webSocketMsg, channel);
  }

  void sendWsMessage(DevMessage webSocketMsg, WebSocketChannel channel) {
    requestId++;
    webSocketMsg.requestID = requestId;
    var serilizedMsg = webSocketMsg.toJson();
    var encodedWebSocketMsg = jsonEncode(serilizedMsg);
    channel.sink.add(encodedWebSocketMsg);
  }

  void processMessage(Map<String, dynamic> data, WebSocketChannel channel,
      BuildContext context) {
    var msgType = data['msgType'];
    switch (msgType) {
      case "connectionInit": //BroadcastData
        onConnectionInit(channel);
        _login(context);
        break;
      case 0: //BroadcastData
        if (data['devModel'] == 12) {
          _processPsMessage(context, data);
        }
        break;
      case 1: // ResponseMessage
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

  void incrementCounter() {
    _count += 1;
    notifyListeners();
  }

  void startRandom() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      _random = Random().nextInt(999);
      notifyListeners();
    });
  }

  void _processPsMessage(BuildContext context, Map<String, dynamic> msg) {
    Provider.of<PowerServiceManager>(context, listen: false)
        .onPsMessageReceived(msg);
  }

  void _login(BuildContext context) {
    Provider.of<ApiController>(context, listen: false)
        .login(ApiController.USERNAME, ApiController.PASSWORD);
  }
}
