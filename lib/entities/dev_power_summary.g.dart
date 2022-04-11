// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dev_power_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevPowerSummary _$DevPowerSummaryFromJson(Map<String, dynamic> json) =>
    DevPowerSummary()
      ..sniu = json['sniu'] as bool?
      ..serialNumber = json['serialNumber'] as String?
      ..deviceID = json['deviceID'] as int?
      ..lastUpdate = json['lastUpdate'] as int?
      ..powerW = (json['powerW'] as num?)?.toDouble()
      ..voltageV = (json['voltageV'] as num?)?.toDouble()
      ..currentA = (json['currentA'] as num?)?.toDouble()
      ..ratedPowerW = (json['ratedPowerW'] as num?)?.toDouble()
      ..powerName = json['powerName'] as String?
      ..energyWh = (json['energyWh'] as num?)?.toDouble()
      ..powerType = json['powerType'] as String?
      ..available = json['available'] as bool?
      ..dailyEnergyWh = (json['dailyEnergyWh'] as num?)?.toDouble()
      ..weeklyEnergyWh = (json['weeklyEnergyWh'] as num?)?.toDouble()
      ..monthlyEnergyWh = (json['monthlyEnergyWh'] as num?)?.toDouble()
      ..yearlyEnergyWh = (json['yearlyEnergyWh'] as num?)?.toDouble()
      ..onlineDevices = json['onlineDevices'] as int?
      ..offlineDevices = json['offlineDevices'] as int?;

Map<String, dynamic> _$DevPowerSummaryToJson(DevPowerSummary instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sniu', instance.sniu);
  writeNotNull('serialNumber', instance.serialNumber);
  writeNotNull('deviceID', instance.deviceID);
  writeNotNull('lastUpdate', instance.lastUpdate);
  writeNotNull('powerW', instance.powerW);
  writeNotNull('voltageV', instance.voltageV);
  writeNotNull('currentA', instance.currentA);
  writeNotNull('ratedPowerW', instance.ratedPowerW);
  writeNotNull('powerName', instance.powerName);
  writeNotNull('energyWh', instance.energyWh);
  writeNotNull('powerType', instance.powerType);
  writeNotNull('available', instance.available);
  writeNotNull('dailyEnergyWh', instance.dailyEnergyWh);
  writeNotNull('weeklyEnergyWh', instance.weeklyEnergyWh);
  writeNotNull('monthlyEnergyWh', instance.monthlyEnergyWh);
  writeNotNull('yearlyEnergyWh', instance.yearlyEnergyWh);
  writeNotNull('onlineDevices', instance.onlineDevices);
  writeNotNull('offlineDevices', instance.offlineDevices);
  return val;
}
