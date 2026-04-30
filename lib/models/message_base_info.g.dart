// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_base_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageBaseInfo _$MessageBaseInfoFromJson(Map<String, dynamic> json) =>
    MessageBaseInfo(
      msgType: json['msgType'] as String?,
      deviceName: json['deviceName'] as String? ?? '',
      deviceType: (json['deviceType'] as num?)?.toInt(),
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$MessageBaseInfoToJson(MessageBaseInfo instance) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
    };
