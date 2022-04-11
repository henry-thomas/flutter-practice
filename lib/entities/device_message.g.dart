// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevMessage _$DevMessageFromJson(Map<String, dynamic> json) => DevMessage()
  ..msgType = json['msgType']
  ..requestID = json['requestID'] as int?
  ..sessionID = json['sessionID'] as String?
  ..devId = json['devId'] as int?
  ..devModel = json['devModel'] as int?
  ..devType = json['devType'] as int?
  ..data = json['data'] as String?
  ..dataExt = json['dataExt'] as String?
  ..dataIdx = json['dataIdx'] as String?
  ..dataClass = json['dataClass'] as String?
  ..dataActual = json['dataActual'] as bool?
  ..success = json['success'] as bool?
  ..successMsg = json['successMsg'] as String?
  ..faultCode = json['faultCode'] as int?
  ..faultMsg = json['faultMsg'] as String?
  ..requiredAck = json['requiredAck'] as bool?
  ..ackID = json['ackID'] as int?
  ..messageList = (json['messageList'] as List<dynamic>?)
      ?.map((e) => DevPowerSummary.fromJson(e as Map<String, dynamic>))
      .toList()
  ..devSerial = json['devSerial'] as String?
  ..devModelId = json['devModelId'] as int?
  ..instr = json['instr'] as String?
  ..loggerSerial = json['loggerSerial'] as String?;

Map<String, dynamic> _$DevMessageToJson(DevMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('msgType', instance.msgType);
  writeNotNull('requestID', instance.requestID);
  writeNotNull('sessionID', instance.sessionID);
  writeNotNull('devId', instance.devId);
  writeNotNull('devModel', instance.devModel);
  writeNotNull('devType', instance.devType);
  writeNotNull('data', instance.data);
  writeNotNull('dataExt', instance.dataExt);
  writeNotNull('dataIdx', instance.dataIdx);
  writeNotNull('dataClass', instance.dataClass);
  writeNotNull('dataActual', instance.dataActual);
  writeNotNull('success', instance.success);
  writeNotNull('successMsg', instance.successMsg);
  writeNotNull('faultCode', instance.faultCode);
  writeNotNull('faultMsg', instance.faultMsg);
  writeNotNull('requiredAck', instance.requiredAck);
  writeNotNull('ackID', instance.ackID);
  writeNotNull('messageList', instance.messageList);
  writeNotNull('devSerial', instance.devSerial);
  writeNotNull('devModelId', instance.devModelId);
  writeNotNull('instr', instance.instr);
  writeNotNull('loggerSerial', instance.loggerSerial);
  return val;
}
