// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calc_power_expression.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalcPowerExpression _$CalcPowerExpressionFromJson(Map<String, dynamic> json) =>
    CalcPowerExpression()
      ..p1 = json['p1'] == null
          ? null
          : DevPowerSummary.fromJson(json['p1'] as Map<String, dynamic>)
      ..p2 = json['p2'] == null
          ? null
          : DevPowerSummary.fromJson(json['p2'] as Map<String, dynamic>)
      ..op = json['op'] as String?;

Map<String, dynamic> _$CalcPowerExpressionToJson(CalcPowerExpression instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('p1', instance.p1);
  writeNotNull('p2', instance.p2);
  writeNotNull('op', instance.op);
  return val;
}
