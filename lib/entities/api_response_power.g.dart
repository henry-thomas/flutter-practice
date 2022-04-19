// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_power.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponsePower _$ApiResponsePowerFromJson(Map<String, dynamic> json) =>
    ApiResponsePower()
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..data = json['data'] as Map<String, dynamic>?;

Map<String, dynamic> _$ApiResponsePowerToJson(ApiResponsePower instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('success', instance.success);
  writeNotNull('message', instance.message);
  writeNotNull('data', instance.data);
  return val;
}
