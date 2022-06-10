import 'package:json_annotation/json_annotation.dart';

part 'energy_storage_db.g.dart';

@JsonSerializable(includeIfNull: false)
class EnergyStorageDb {
  bool available = false;
  double capacityAh = 0;
  double capacityP = 0;
  double currentA = 0;
  DateTime? lastUpdate;
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

  EnergyStorageDb();

  Map<String, dynamic> toJson() => _$EnergyStorageDbToJson(this);

  factory EnergyStorageDb.fromJson(Map<String, dynamic> json) =>
      _$EnergyStorageDbFromJson(json);
}
