import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(includeIfNull: false)
class ApiResponse {
  bool? success;
  String? message;
  List<dynamic>? data;

  ApiResponse();

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
}
