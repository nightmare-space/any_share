// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryMessages _$HistoryMessagesFromJson(Map<String, dynamic> json) =>
    HistoryMessages(
      datas: (json['datas'] as List<dynamic>?)
          ?.map((e) => HistoryMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryMessagesToJson(HistoryMessages instance) =>
    <String, dynamic>{'datas': instance.datas};

HistoryMessage _$HistoryMessageFromJson(Map<String, dynamic> json) =>
    HistoryMessage(
      id: json['id'] as String?,
      url: json['url'] as String?,
      deviceName: json['deviceName'] as String?,
    );

Map<String, dynamic> _$HistoryMessageToJson(HistoryMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'deviceName': instance.deviceName,
    };
