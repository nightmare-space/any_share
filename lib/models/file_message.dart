import 'package:json_annotation/json_annotation.dart';

import 'message_base_info.dart';

part 'file_message.g.dart';

@JsonSerializable()
class FileMessage extends MessageBaseInfo {
  FileMessage({
    this.fileName,
    this.fileSize,
    this.port,
    this.addrs,
    this.filePath,
    super.deviceName,
    super.msgType = 'file',
  });

  String? fileName;
  String? filePath;
  String? fileSize;
  List<String?>? addrs;
  String? url;
  int? port;

  factory FileMessage.fromJson(Map<String, dynamic> json) => _$FileMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FileMessageToJson(this);
}
