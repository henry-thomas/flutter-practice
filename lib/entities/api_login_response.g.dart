// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiLoginResponse _$ApiLoginResponseFromJson(Map<String, dynamic> json) =>
    ApiLoginResponse()
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..data = json['data'] as Map<String, dynamic>;

Map<String, dynamic> _$ApiLoginResponseToJson(ApiLoginResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('success', instance.success);
  writeNotNull('message', instance.message);
  val['data'] = instance.data;
  return val;
}
