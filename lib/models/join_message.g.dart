// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinMessage _$JoinMessageFromJson(Map<String, dynamic> json) =>
    JoinMessage(msgType: json['msgType'] as String? ?? 'join')
      ..deviceName = json['deviceName'] as String?
      ..deviceId = json['deviceId'] as String?
      ..deviceType = (json['deviceType'] as num?)?.toInt()
      ..addrs = (json['addrs'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList()
      ..messagePort = (json['messagePort'] as num?)?.toInt()
      ..filePort = (json['filePort'] as num?)?.toInt();

Map<String, dynamic> _$JoinMessageToJson(JoinMessage instance) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'addrs': instance.addrs,
      'messagePort': instance.messagePort,
      'filePort': instance.filePort,
    };
