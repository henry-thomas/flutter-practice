// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_paginated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponsePaginated _$ApiResponsePaginatedFromJson(
        Map<String, dynamic> json) =>
    ApiResponsePaginated()
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..data = json['data'] as Map<String, dynamic>?;

Map<String, dynamic> _$ApiResponsePaginatedToJson(
    ApiResponsePaginated instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('success', instance.success);
  writeNotNull('message', instance.message);
  writeNotNull('data', instance.data);
  return val;
}
