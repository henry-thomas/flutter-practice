import 'package:json_annotation/json_annotation.dart';

part 'energy_storage.g.dart';

@JsonSerializable(includeIfNull: false)
class EnergyStorage {
  bool available = false;
  double capacityAh = 0;
  double capacityP = 0;
  double currentA = 0;
  double lastUpdate = 0;
  double powerW = 0;
  String? serialNumber;
  int? deviceID;
  double ratedCapacityAh = 0;
  double ratedChargeCurrentC = 0;
  double ratedDischargeCurrentC = 0;
  double ratedVoltageV = 0;
  double? ratedPowerW = 0;
  double remainingTimeSign = 0;
  String storageName = "";
  double voltageV = 0;
  int? onlineSt = 0;
  int? offlineSt = 0;

  EnergyStorage();

  Map<String, dynamic> toJson() => _$EnergyStorageToJson(this);

  factory EnergyStorage.fromJson(Map<String, dynamic> json) =>
      _$EnergyStorageFromJson(json);
}
