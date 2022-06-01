import 'package:json_annotation/json_annotation.dart';

part 'logger_config.g.dart';

@JsonSerializable(includeIfNull: false)
class LoggerConfig {
  int? loggerGraphConfigId;
  int? loggerId;
  String? confKeyGroup;
  String? confKey;
  String? confGroup;
  String? confValue;

  LoggerConfig();

  Map<String, dynamic> toJson() => _$LoggerConfigToJson(this);

  factory LoggerConfig.fromJson(Map<String, dynamic> json) =>
      _$LoggerConfigFromJson(json);
}
