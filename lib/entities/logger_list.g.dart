// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logger_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggerList _$LoggerListFromJson(Map<String, dynamic> json) => LoggerList()
  ..loggerDescription = json['loggerDescription'] as String?
  ..loggerSerial = json['loggerSerial'] as String?;

Map<String, dynamic> _$LoggerListToJson(LoggerList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('loggerDescription', instance.loggerDescription);
  writeNotNull('loggerSerial', instance.loggerSerial);
  return val;
}
