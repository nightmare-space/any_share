import 'package:json_annotation/json_annotation.dart';
import 'text_message.dart';
part 'clipboard_message.g.dart';

@JsonSerializable()
class ClipboardMessage extends TextMessage {
  ClipboardMessage({
    super.deviceName,
    super.msgType = 'clip',
    super.content,
  });

  factory ClipboardMessage.fromJson(Map<String, dynamic> json) => _$ClipboardMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClipboardMessageToJson(this);
}
