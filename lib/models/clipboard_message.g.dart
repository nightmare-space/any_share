// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clipboard_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClipboardMessage _$ClipboardMessageFromJson(Map<String, dynamic> json) =>
    ClipboardMessage(
        deviceName: json['deviceName'] as String? ?? '',
        msgType: json['msgType'] as String? ?? 'clip',
        content: json['content'] as String?,
      )
      ..deviceId = json['deviceId'] as String?
      ..deviceType = (json['deviceType'] as num?)?.toInt();

Map<String, dynamic> _$ClipboardMessageToJson(ClipboardMessage instance) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'content': instance.content,
    };
