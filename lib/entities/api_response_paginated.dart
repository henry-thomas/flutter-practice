import 'package:json_annotation/json_annotation.dart';

part 'api_response_paginated.g.dart';

@JsonSerializable(includeIfNull: false)
class ApiResponsePaginated {
  bool? success;
  String? message;
  Map<String, dynamic>? data;

  ApiResponsePaginated();

  Map<String, dynamic> toJson() => _$ApiResponsePaginatedToJson(this);

  factory ApiResponsePaginated.fromJson(Map<String, dynamic> json) =>
      _$ApiResponsePaginatedFromJson(json);
}
