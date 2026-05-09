// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotifyMessage _$NotifyMessageFromJson(Map<String, dynamic> json) =>
    NotifyMessage(
        hash: json['hash'] as String?,
        addrs: (json['addrs'] as List<dynamic>?)
            ?.map((e) => e as String?)
            .toList(),
        port: (json['port'] as num?)?.toInt(),
        msgType: json['msgType'] as String? ?? 'notify',
      )
      ..deviceName = json['deviceName'] as String?
      ..deviceId = json['deviceId'] as String?
      ..deviceType = const DeviceTypeConverter().fromJson(
        json['deviceType'] as String?,
      );

Map<String, dynamic> _$NotifyMessageToJson(NotifyMessage instance) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'deviceType': const DeviceTypeConverter().toJson(instance.deviceType),
      'hash': instance.hash,
      'addrs': instance.addrs,
      'port': instance.port,
    };
