// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_file_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrowserFileMessage _$BrowserFileMessageFromJson(Map<String, dynamic> json) =>
    BrowserFileMessage(
      fileName: json['fileName'] as String?,
      fileSize: json['fileSize'] as String?,
      hash: json['hash'] as String?,
      blob: json['blob'] as String?,
      deviceName: json['deviceName'] as String? ?? '',
      deviceId: json['deviceId'] as String?,
      deviceType: const DeviceTypeConverter().fromJson(
        json['deviceType'] as String?,
      ),
      msgType: json['msgType'] as String? ?? 'webfile',
    );

Map<String, dynamic> _$BrowserFileMessageToJson(BrowserFileMessage instance) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'deviceType': const DeviceTypeConverter().toJson(instance.deviceType),
      'fileName': instance.fileName,
      'fileSize': instance.fileSize,
      'hash': instance.hash,
      'blob': instance.blob,
    };
