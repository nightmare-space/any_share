import 'package:json_annotation/json_annotation.dart';
import 'message_base_info.dart';
part 'join_message.g.dart';

@JsonSerializable()
class JoinMessage extends MessageBaseInfo {
  JoinMessage({
    super.msgType = 'join',
  });

  List<String?>? addrs;
  int? messagePort;
  int? filePort;

  factory JoinMessage.fromJson(Map<String, dynamic> json) => _$JoinMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JoinMessageToJson(this);
}
