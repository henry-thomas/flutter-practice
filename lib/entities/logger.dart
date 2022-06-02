import 'package:json_annotation/json_annotation.dart';
import 'package:provider_test/entities/sub_device.dart';

part 'logger.g.dart';

@JsonSerializable(includeIfNull: false)
class Logger {
  String? serNum;
  String? model;
  String? installDate;
  String? description;
  String? installationAddress;
  String? shortName;
  String? lat;
  String? lng;
  String? lastSeen;
  String? connected;
  String? swVersion;
  List<SubDevice>? devList;

  Logger();

  Map<String, dynamic> toJson() => _$LoggerToJson(this);

  factory Logger.fromJson(Map<String, dynamic> json) => _$LoggerFromJson(json);
}
