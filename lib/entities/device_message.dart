import 'package:json_annotation/json_annotation.dart';
import 'package:provider_test/entities/dev_power_summary.dart';

part 'device_message.g.dart';

@JsonSerializable(includeIfNull: false)
class DevMessage {
  var msgType;
  int? requestID;
  String? sessionID;
  int? devId;
  int? devModel;
  int? devType;
  String? data;
  String? dataExt;
  String? dataIdx;
  String? dataClass;
  bool? dataActual;
  bool? success;
  String? successMsg;
  int? faultCode;
  String? faultMsg;
  bool? requiredAck;
  int? ackID;
  List? messageList;
  String? devSerial;
  int? devModelId;
  String? instr;
  String? loggerSerial;

  DevMessage();

  Map<String, dynamic> toJson() => _$DevMessageToJson(this);

  factory DevMessage.fromJson(Map<String, dynamic> json) =>
      _$DevMessageFromJson(json);
}
