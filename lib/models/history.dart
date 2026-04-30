import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'history.g.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

@JsonSerializable()
class HistoryMessages {
  HistoryMessages({
    this.datas,
  });

  List<HistoryMessage>? datas;

  factory HistoryMessages.fromJson(Map<String, dynamic> json) => _$HistoryMessagesFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryMessagesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HistoryMessage {
  HistoryMessage({
    this.id,
    this.url,
    this.deviceName,
  });

  String? id;
  String? url;
  String? deviceName;

  factory HistoryMessage.fromJson(Map<String, dynamic> json) => _$HistoryMessageFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryMessageToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is HistoryMessage) {
      return id == other.id;
    }
    return false;
  }
}
