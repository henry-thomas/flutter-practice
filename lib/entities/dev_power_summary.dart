import 'package:json_annotation/json_annotation.dart';

part 'dev_power_summary.g.dart';

@JsonSerializable(includeIfNull: false)
class DevPowerSummary {
  bool? sniu; // short name in use
  String? serialNumber;
  int? deviceID;
  int? lastUpdate;
  double? powerW = 0;
  double? voltageV = 0;
  double? currentA;
  double? ratedPowerW = 0;
  String? powerName;
  double? energyWh;
  String? powerType;
  bool? available;
  double? dailyEnergyWh;
  double? weeklyEnergyWh;
  double? monthlyEnergyWh;
  double? yearlyEnergyWh;
  int? onlineDevices;
  int? offlineDevices;

  DevPowerSummary();

  Map<String, dynamic> toJson() => _$DevPowerSummaryToJson(this);

  factory DevPowerSummary.fromJson(Map<String, dynamic> json) =>
      _$DevPowerSummaryFromJson(json);
}
