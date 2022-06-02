import 'package:json_annotation/json_annotation.dart';

part 'sub_device.g.dart';

@JsonSerializable(includeIfNull: false)
class SubDevice {
  String? parrentId;
  bool? hidden;
  int? deviceID;
  int? modelID;
  int? subModelID;
  int? typeID;
  DateTime? installedDate;
  String? serialNumber;
  String? hwVer;
  String? fwVer;
  String? deviceName;
  String? displayName;
  String? status;
  String? manufacturer;
  int? lastSeen;
  bool? connected;
  int? subDevID;
  int? logerMyPowerId;

  SubDevice();

  Map<String, dynamic> toJson() => _$SubDeviceToJson(this);

  factory SubDevice.fromJson(Map<String, dynamic> json) =>
      _$SubDeviceFromJson(json);
}
