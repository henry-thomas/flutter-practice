import 'package:json_annotation/json_annotation.dart';

part 'api_login_response.g.dart';

@JsonSerializable(includeIfNull: false)
class ApiLoginResponse {
  bool? success;
  String? message;
  Map<String, dynamic> data = {};

  ApiLoginResponse();

  Map<String, dynamic> toJson() => _$ApiLoginResponseToJson(this);

  factory ApiLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiLoginResponseFromJson(json);
}
