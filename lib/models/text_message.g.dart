// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessage _$TextMessageFromJson(Map<String, dynamic> json) =>
    TextMessage(
        content: json['content'] as String?,
        deviceName: json['deviceName'] as String? ?? '',
        msgType: json['msgType'] as String? ?? 'text',
      )
      ..deviceId = json['deviceId'] as String?
      ..deviceType = $enumDecodeNullable(
        _$DeviceTypeEnumMap,
        json['deviceType'],
      );

Map<String, dynamic> _$TextMessageToJson(TextMessage instance) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'deviceType': _$DeviceTypeEnumMap[instance.deviceType],
      'content': instance.content,
    };

const _$DeviceTypeEnumMap = {
  DeviceType.phone: 'phone',
  DeviceType.desktop: 'desktop',
  DeviceType.browser: 'browser',
};
