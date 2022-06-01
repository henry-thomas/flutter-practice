// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logger_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggerConfig _$LoggerConfigFromJson(Map<String, dynamic> json) => LoggerConfig()
  ..loggerGraphConfigId = json['loggerGraphConfigId'] as int?
  ..loggerId = json['loggerId'] as int?
  ..confKeyGroup = json['confKeyGroup'] as String?
  ..confKey = json['confKey'] as String?
  ..confGroup = json['confGroup'] as String?
  ..confValue = json['confValue'] as String?;

Map<String, dynamic> _$LoggerConfigToJson(LoggerConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('loggerGraphConfigId', instance.loggerGraphConfigId);
  writeNotNull('loggerId', instance.loggerId);
  writeNotNull('confKeyGroup', instance.confKeyGroup);
  writeNotNull('confKey', instance.confKey);
  writeNotNull('confGroup', instance.confGroup);
  writeNotNull('confValue', instance.confValue);
  return val;
}
