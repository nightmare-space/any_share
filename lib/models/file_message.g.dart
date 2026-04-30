// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileMessage _$FileMessageFromJson(Map<String, dynamic> json) =>
    FileMessage(
        fileName: json['fileName'] as String?,
        fileSize: json['fileSize'] as String?,
        port: (json['port'] as num?)?.toInt(),
        addrs: (json['addrs'] as List<dynamic>?)
            ?.map((e) => e as String?)
            .toList(),
        filePath: json['filePath'] as String?,
        deviceName: json['deviceName'] as String? ?? '',
        msgType: json['msgType'] as String? ?? 'file',
      )
      ..deviceId = json['deviceId'] as String?
      ..deviceType = (json['deviceType'] as num?)?.toInt()
      ..url = json['url'] as String?;

Map<String, dynamic> _$FileMessageToJson(FileMessage instance) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'fileName': instance.fileName,
      'filePath': instance.filePath,
      'fileSize': instance.fileSize,
      'addrs': instance.addrs,
      'url': instance.url,
      'port': instance.port,
    };
