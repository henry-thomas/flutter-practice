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

  static String loggerSerial = "SLV209980540";
  static String devModel = "12";
  static String jwt =
      "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxIiwic2NlIjoibW9iaWxlIn0.ec-bcZz--mHaD_J3ABBwcUVs4VN-FjhX0e8sWoqVvjAATBrR5Ar8QlzxJJAfeioX1f2YdhWL8uKzj15FdjFjmxfMLrkExtbbN8dEgQWwbSDne0uG7cehdxWtVCuBS9NaRSg27xq3z8Ab4XNmodaSgSr0DbypI1QYXOTC7l9G_lFlBy6lVwmtoFwi_TMxZPNhNg8P9WM10bIMgO0Zg2a-FpzDSGIZc0xsnPz17Y50Cji9H2bDdfVBRFsTKKrAWqP1X_7RvkczCr3OCLl9eOGwGFClmkaEYwda4u2W7HHjWOLhY9-7oKDUirRtp_tsiCKdU4qbaBvbN4bK4XF_s2m2qw";
  static String url = 'ws://192.168.100.18:8084/SolarMDApi/mobile?token=' +
      jwt +
      '&loggerSerial=' +
      loggerSerial +
      '&deviceModel=' +
      devModel;

  static final channel = WebSocketChannel.connect(Uri.parse(url));

  var stream = channel.stream;

  void initWsManager(BuildContext context) async {
    stream.listen((event) => {processMessage(jsonDecode(event), context)});
  }

  void requestBcMsg(channel) {
    DevMessage webSocketMsg = DevMessage();
    webSocketMsg.instr = "broadcastRequest";
    webSocketMsg.msgType = "devInstruction";
    webSocketMsg.devModel = 12;
    webSocketMsg.devModelId = 12;
    webSocketMsg.loggerSerial = ApiController.SELECTED_LOGGER;

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
    webSocketMsg.loggerSerial = ApiController.SELECTED_LOGGER;

    sendWsMessage(webSocketMsg, channel);
  }

  void sendWsMessage(DevMessage webSocketMsg, WebSocketChannel channel) {
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
        onConnectionInit(channel);
        break;
      case 0: //BroadcastData
        if (data['devModel'] == 12) {
          // _processPsMessage(data, context);
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

  // void _processPsMessage(Map<String, dynamic> msg, BuildContext context) {
  //   Provider.of<PowerServiceManager>(context, listen: false)
  //       .onPsMessageReceived(msg);
  // }
}
