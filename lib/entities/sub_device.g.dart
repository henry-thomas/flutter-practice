// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubDevice _$SubDeviceFromJson(Map<String, dynamic> json) => SubDevice()
  ..parrentId = json['parrentId'] as String?
  ..hidden = json['hidden'] as bool?
  ..deviceID = json['deviceID'] as int?
  ..modelID = json['modelID'] as int?
  ..subModelID = json['subModelID'] as int?
  ..typeID = json['typeID'] as int?
  ..installedDate = json['installedDate'] == null
      ? null
      : DateTime.parse(json['installedDate'] as String)
  ..serialNumber = json['serialNumber'] as String?
  ..hwVer = json['hwVer'] as String?
  ..fwVer = json['fwVer'] as String?
  ..deviceName = json['deviceName'] as String?
  ..displayName = json['displayName'] as String?
  ..status = json['status'] as String?
  ..manufacturer = json['manufacturer'] as String?
  ..lastSeen = json['lastSeen'] as int?
  ..connected = json['connected'] as bool?
  ..subDevID = json['subDevID'] as int?
  ..logerMyPowerId = json['logerMyPowerId'] as int?;

Map<String, dynamic> _$SubDeviceToJson(SubDevice instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('parrentId', instance.parrentId);
  writeNotNull('hidden', instance.hidden);
  writeNotNull('deviceID', instance.deviceID);
  writeNotNull('modelID', instance.modelID);
  writeNotNull('subModelID', instance.subModelID);
  writeNotNull('typeID', instance.typeID);
  writeNotNull('installedDate', instance.installedDate?.toIso8601String());
  writeNotNull('serialNumber', instance.serialNumber);
  writeNotNull('hwVer', instance.hwVer);
  writeNotNull('fwVer', instance.fwVer);
  writeNotNull('deviceName', instance.deviceName);
  writeNotNull('displayName', instance.displayName);
  writeNotNull('status', instance.status);
  writeNotNull('manufacturer', instance.manufacturer);
  writeNotNull('lastSeen', instance.lastSeen);
  writeNotNull('connected', instance.connected);
  writeNotNull('subDevID', instance.subDevID);
  writeNotNull('logerMyPowerId', instance.logerMyPowerId);
  return val;
}
