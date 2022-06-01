import 'package:json_annotation/json_annotation.dart';
import 'package:provider_test/entities/dev_power_summary.dart';

part 'calc_power_expression.g.dart';

@JsonSerializable(includeIfNull: false)
class CalcPowerExpression {
  DevPowerSummary? p1;
  DevPowerSummary? p2;
  String? op;

  CalcPowerExpression();

  Map<String, dynamic> toJson() => _$CalcPowerExpressionToJson(this);

  factory CalcPowerExpression.fromJson(Map<String, dynamic> json) =>
      _$CalcPowerExpressionFromJson(json);
}
