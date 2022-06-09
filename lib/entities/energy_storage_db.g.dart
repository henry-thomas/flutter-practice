// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_storage_db.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnergyStorageDb _$EnergyStorageDbFromJson(Map<String, dynamic> json) =>
    EnergyStorageDb()
      ..available = json['available'] as bool
      ..capacityAh = (json['capacityAh'] as num).toDouble()
      ..capacityP = (json['capacityP'] as num).toDouble()
      ..currentA = (json['currentA'] as num).toDouble()
      ..lastUpdate = json['lastUpdate'] == null
          ? null
          : DateTime.parse(json['lastUpdate'] as String)
      ..powerW = (json['powerW'] as num).toDouble()
      ..serialNumber = json['serialNumber'] as String?
      ..deviceID = json['deviceID'] as int?
      ..ratedCapacityAh = (json['ratedCapacityAh'] as num).toDouble()
      ..ratedChargeCurrentC = (json['ratedChargeCurrentC'] as num).toDouble()
      ..ratedDischargeCurrentC =
          (json['ratedDischargeCurrentC'] as num).toDouble()
      ..ratedVoltageV = (json['ratedVoltageV'] as num).toDouble()
      ..ratedPowerW = (json['ratedPowerW'] as num?)?.toDouble()
      ..remainingTimeSign = (json['remainingTimeSign'] as num).toDouble()
      ..storageName = json['storageName'] as String
      ..voltageV = (json['voltageV'] as num).toDouble()
      ..onlineSt = json['onlineSt'] as int?
      ..offlineSt = json['offlineSt'] as int?;

Map<String, dynamic> _$EnergyStorageDbToJson(EnergyStorageDb instance) {
  final val = <String, dynamic>{
    'available': instance.available,
    'capacityAh': instance.capacityAh,
    'capacityP': instance.capacityP,
    'currentA': instance.currentA,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lastUpdate', instance.lastUpdate?.toIso8601String());
  val['powerW'] = instance.powerW;
  writeNotNull('serialNumber', instance.serialNumber);
  writeNotNull('deviceID', instance.deviceID);
  val['ratedCapacityAh'] = instance.ratedCapacityAh;
  val['ratedChargeCurrentC'] = instance.ratedChargeCurrentC;
  val['ratedDischargeCurrentC'] = instance.ratedDischargeCurrentC;
  val['ratedVoltageV'] = instance.ratedVoltageV;
  writeNotNull('ratedPowerW', instance.ratedPowerW);
  val['remainingTimeSign'] = instance.remainingTimeSign;
  val['storageName'] = instance.storageName;
  val['voltageV'] = instance.voltageV;
  writeNotNull('onlineSt', instance.onlineSt);
  writeNotNull('offlineSt', instance.offlineSt);
  return val;
}
