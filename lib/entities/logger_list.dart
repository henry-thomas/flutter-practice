import 'package:json_annotation/json_annotation.dart';

part 'logger_list.g.dart';

@JsonSerializable(includeIfNull: false)
class LoggerList {

  String? loggerDescription;
  String? loggerSerial;

  LoggerList();

  Map<String, dynamic> toJson() => _$LoggerListToJson(this);

  factory LoggerList.fromJson(Map<String, dynamic> json) =>
      _$LoggerListFromJson(json);
}