import 'package:json_annotation/json_annotation.dart';
import 'models.dart';
part 'dir_message.g.dart';

@JsonSerializable()
@JsonSerializable()
class DirMessage extends MessageBaseInfo {
  DirMessage({
    this.dirName,
    this.fullSize,
    this.canDownload = false,
    this.paths = const [],
    this.urlPrifix,
    this.addrs,
    this.port,
    super.deviceName,
    super.deviceId,
    super.deviceType,
    super.msgType = 'dir',
  });

  String? dirName;
  int? fullSize;

  @JsonKey(defaultValue: false)
  bool? canDownload;

  @JsonKey(defaultValue: [])
  List<String?>? paths;

  String? urlPrifix;
  List<String?>? addrs;
  String? url;
  int? port;

  factory DirMessage.fromJson(Map<String, dynamic> json) => _$DirMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DirMessageToJson(this);
}

@JsonSerializable()
class DirPartMessage extends MessageBaseInfo {
  DirPartMessage({
    this.path,
    this.stat,
    this.partOf,
    this.size,
    super.deviceName,
    super.deviceId,
    super.deviceType,
    super.msgType = 'dirPart',
  });

  String? path;
  String? stat;
  String? partOf;
  int? size;

  factory DirPartMessage.fromJson(Map<String, dynamic> json) => _$DirPartMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DirPartMessageToJson(this);
}
