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

  static String loggerSerial = "SLV216362637";
  static String devModel = "12";
  static String jwt =
      "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxIiwic2NlIjoibW9iaWxlIn0.Vcxby9gFQBg7nVq3CP67hMcq2eeKA1OreipFrNQkGfv5R8emjS8Td8sjK91LncWCTF9qubsX_LzggkcuXhc6E8NJFKD36NOHMZdDrkw8N-RE1BDUvjsBXsacxFNI6aauX8jFkiGuQH6yRggVDc5Q5mb3dCnidrKDzdjkUSgRfoe0IGE1i-sF88yW8P7uyCfheB7fHAPXX9Fuyon6IPpM0eDJVDoe0aQC9zYZObfQrxueVetcqo3N9QY8Xrfbz08xn1yPZpTZfhcJ3dGhCJM6Wsz2yehlfCFVjc2kYTAAH0eobEyIY7AYyvjYkpGvcDR-GLG7EPaJeQf06vclJiEI0A";
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
          _processPsMessage(data, context);
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

  void _processPsMessage(Map<String, dynamic> msg, BuildContext context) {
    Provider.of<PowerServiceManager>(context, listen: false)
        .onPsMessageReceived(msg);
  }
}
