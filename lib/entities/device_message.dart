class DevMessage {
  int? devModel;
  String? devSerial;
  int? devModelId;
  String? instr;
  String? msgType;
  String? sessionID;
  int? requestID;
  String? loggerSerial;

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  String toString() {
    return 'Message{subDevSerial: $devSerial, subDevModelId: $devModelId, instr: $instr, msgType: $msgType, sessionID: $sessionID, requestID: $requestID, devModel: $devModel, loggerSerial: $loggerSerial}';
  }

//   Message(this.subDevSerial);

}

Map<String, dynamic> _$MessageToJson(DevMessage instance) => <String, dynamic>{
      'devSerial': instance.devSerial,
      'devModelId': instance.devModelId,
      'instr': instance.instr,
      'msgType': instance.msgType,
      'sessionID': instance.sessionID,
      'requestID': instance.requestID,
      'devModel': instance.devModel,
    };
