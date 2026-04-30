import 'package:json_annotation/json_annotation.dart';
import 'message_base_info.dart';
part 'notify_message.g.dart';

@JsonSerializable()
class NotifyMessage extends MessageBaseInfo {
  NotifyMessage({
    this.hash,
    this.addrs,
    this.port,
    super.msgType = 'notify',
  });

  String? hash;
  List<String?>? addrs;
  int? port;

  factory NotifyMessage.fromJson(Map<String, dynamic> json) => _$NotifyMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NotifyMessageToJson(this);
}
