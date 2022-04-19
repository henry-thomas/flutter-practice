import 'package:json_annotation/json_annotation.dart';

part 'power_type.g.dart';

@JsonSerializable(includeIfNull: false)
class PowerType {
  int? id;
  int? loggerId;
  String? powerName;
  String? powerType;

  PowerType();

  Map<String, dynamic> toJson() => _$PowerTypeToJson(this);

  factory PowerType.fromJson(Map<String, dynamic> json) =>
      _$PowerTypeFromJson(json);
}
