// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dir_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirMessage _$DirMessageFromJson(Map<String, dynamic> json) => DirMessage(
  dirName: json['dirName'] as String?,
  fullSize: (json['fullSize'] as num?)?.toInt(),
  canDownload: json['canDownload'] as bool? ?? false,
  paths:
      (json['paths'] as List<dynamic>?)?.map((e) => e as String?).toList() ??
      [],
  urlPrifix: json['urlPrifix'] as String?,
  addrs: (json['addrs'] as List<dynamic>?)?.map((e) => e as String?).toList(),
  port: (json['port'] as num?)?.toInt(),
  deviceName: json['deviceName'] as String? ?? '',
  deviceId: json['deviceId'] as String?,
  deviceType: (json['deviceType'] as num?)?.toInt(),
  msgType: json['msgType'] as String? ?? 'dir',
)..url = json['url'] as String?;

Map<String, dynamic> _$DirMessageToJson(DirMessage instance) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'dirName': instance.dirName,
      'fullSize': instance.fullSize,
      'canDownload': instance.canDownload,
      'paths': instance.paths,
      'urlPrifix': instance.urlPrifix,
      'addrs': instance.addrs,
      'url': instance.url,
      'port': instance.port,
    };

DirPartMessage _$DirPartMessageFromJson(Map<String, dynamic> json) =>
    DirPartMessage(
      path: json['path'] as String?,
      stat: json['stat'] as String?,
      partOf: json['partOf'] as String?,
      size: (json['size'] as num?)?.toInt(),
      deviceName: json['deviceName'] as String? ?? '',
      deviceId: json['deviceId'] as String?,
      deviceType: (json['deviceType'] as num?)?.toInt(),
      msgType: json['msgType'] as String? ?? 'dirPart',
    );

Map<String, dynamic> _$DirPartMessageToJson(DirPartMessage instance) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'path': instance.path,
      'stat': instance.stat,
      'partOf': instance.partOf,
      'size': instance.size,
    };
