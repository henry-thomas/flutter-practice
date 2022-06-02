import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/entities/calc_power_expression.dart';
import 'package:provider_test/entities/dev_power_summary.dart';
import 'package:provider_test/entities/device_message.dart';
import 'package:provider_test/entities/logger.dart';
import 'package:provider_test/entities/logger_config.dart';
import 'package:provider_test/entities/logger_list.dart';
import 'package:provider_test/entities/power_type.dart';
import 'package:provider_test/providers/websocket/ps_manager.dart';
import 'package:provider_test/providers/websocket/ws_manager.dart';

import '../screens/dashboardScreen/dashboardAnimation/dashboard_animation_provider.dart';

class DeviceManager extends ChangeNotifier {
  List<Logger> _loggerList = [];
  final Map<String?, Logger> _serLoggerMap = {};
  Logger? _selectedLogger;

  List<Logger> get getLoggerList {
    return _loggerList;
  }

  Logger? get getSelectedLogger {
    if (_loggerList.isEmpty) {
      return null;
    }
    _selectedLogger ??= _loggerList[0];
    return _selectedLogger;
  }

  void setSelectedLogger(BuildContext context, String serNum) {
    _selectedLogger = _serLoggerMap[serNum];
    Provider.of<WsManager>(context, listen: false).initWs(context);
    Provider.of<PowerServiceManager>(context, listen: false).init(context);
    notifyListeners();
  }

  Future<List<Logger>> _getLoggerList(BuildContext context) async {
    var loggerList = await Provider.of<ApiController>(context, listen: false)
        .getLoggerList();
    return loggerList;
  }

  Future init(BuildContext context) async {
    _loggerList = await _getLoggerList(context);

    for (var i = 0; i < _loggerList.length; i++) {
      _serLoggerMap[_loggerList[i].serNum] = _loggerList[i];
    }

    _selectedLogger ??= _loggerList[0];
    notifyListeners();
  }

  // final apiController = Provider.of<ApiController>(context);
}
