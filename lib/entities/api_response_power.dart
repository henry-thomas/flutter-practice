import 'package:json_annotation/json_annotation.dart';

part 'api_response_power.g.dart';

@JsonSerializable(includeIfNull: false)
class ApiResponsePower {
  bool? success;
  String? message;
  Map<String, dynamic>? data;

  ApiResponsePower();

  Map<String, dynamic> toJson() => _$ApiResponsePowerToJson(this);

  factory ApiResponsePower.fromJson(Map<String, dynamic> json) =>
      _$ApiResponsePowerFromJson(json);
}
