// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Logger _$LoggerFromJson(Map<String, dynamic> json) => Logger()
  ..serNum = json['serNum'] as String?
  ..model = json['model'] as String?
  ..installDate = json['installDate'] as String?
  ..description = json['description'] as String?
  ..installationAddress = json['installationAddress'] as String?
  ..shortName = json['shortName'] as String?
  ..lat = (json['lat'] as num?)?.toDouble()
  ..lng = (json['lng'] as num?)?.toDouble()
  ..lastSeen = json['lastSeen'] as String?
  ..connected = json['connected'] as bool?
  ..swVersion = json['swVersion'] as String?
  ..devList = (json['devList'] as List<dynamic>?)
      ?.map((e) => SubDevice.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$LoggerToJson(Logger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('serNum', instance.serNum);
  writeNotNull('model', instance.model);
  writeNotNull('installDate', instance.installDate);
  writeNotNull('description', instance.description);
  writeNotNull('installationAddress', instance.installationAddress);
  writeNotNull('shortName', instance.shortName);
  writeNotNull('lat', instance.lat);
  writeNotNull('lng', instance.lng);
  writeNotNull('lastSeen', instance.lastSeen);
  writeNotNull('connected', instance.connected);
  writeNotNull('swVersion', instance.swVersion);
  writeNotNull('devList', instance.devList);
  return val;
}
