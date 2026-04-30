import 'package:json_annotation/json_annotation.dart';
import 'message_base_info.dart';
part 'browser_file_message.g.dart';

@JsonSerializable()
class BrowserFileMessage extends MessageBaseInfo {
  BrowserFileMessage({
    this.fileName,
    this.fileSize,
    this.hash,
    this.blob,
    super.deviceName,
    super.deviceId,
    super.deviceType,
    super.msgType = 'webfile',
  });

  String? fileName;
  String? fileSize;
  String? hash;
  String? blob;

  factory BrowserFileMessage.fromJson(Map<String, dynamic> json) => _$BrowserFileMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BrowserFileMessageToJson(this);
}
