import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'browser_file_message.dart';
import 'clipboard_message.dart';
import 'dir_message.dart';
import 'file_message.dart';
import 'join_message.dart';
import 'notify_message.dart';
import 'text_message.dart';

part 'message_base_info.g.dart';

@JsonSerializable()
class MessageBaseInfo {
  MessageBaseInfo({
    this.msgType,
    this.deviceName = '',
    this.deviceType,
    this.deviceId,
  });

  factory MessageBaseInfo.resolveMessage(Map<String, dynamic> json) {
    String? msgType = json['msgType'];
    switch (msgType) {
      case 'file':
        return FileMessage.fromJson(json);
      case 'text':
        return TextMessage.fromJson(json);
      case 'dir':
        return DirMessage.fromJson(json);
      case 'dirPart':
        return DirPartMessage.fromJson(json);
      case 'clip':
        return ClipboardMessage.fromJson(json);
      case 'webfile':
        return BrowserFileMessage.fromJson(json);
      case 'notify':
        return NotifyMessage.fromJson(json);
      case 'join':
        return JoinMessage.fromJson(json);
    }
    throw Exception('Unknown message type: $msgType');
  }

  /// 消息类型
  /// Message Type
  String? msgType;

  /// 发送设备的名称
  /// The name of the sending device
  String? deviceName;

  /// 用来做发送设备的唯一标识
  /// Used as a unique identifier for the sending device
  String? deviceId;

  /// 设备类型
  /// Device Type
  int? deviceType;

  factory MessageBaseInfo.fromJson(Map<String, dynamic> json) => _$MessageBaseInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageBaseInfoToJson(this);

  @override
  String toString() {
    return json.encode(this);
  }
}
