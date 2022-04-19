// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PowerType _$PowerTypeFromJson(Map<String, dynamic> json) => PowerType()
  ..id = json['id'] as int?
  ..loggerId = json['loggerId'] as int?
  ..powerName = json['powerName'] as String?
  ..powerType = json['powerType'] as String?;

Map<String, dynamic> _$PowerTypeToJson(PowerType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('loggerId', instance.loggerId);
  writeNotNull('powerName', instance.powerName);
  writeNotNull('powerType', instance.powerType);
  return val;
}
