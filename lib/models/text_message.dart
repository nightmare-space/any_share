import 'package:json_annotation/json_annotation.dart';
import 'message_base_info.dart';

part 'text_message.g.dart';

@JsonSerializable()
class TextMessage extends MessageBaseInfo {
  TextMessage({
    this.content,
    super.deviceName,
    super.msgType = 'text',
  });

  String? content;

  factory TextMessage.fromJson(Map<String, dynamic> json) => _$TextMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TextMessageToJson(this);
}
