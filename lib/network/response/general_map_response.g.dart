// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_map_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralMapResponse _$GeneralMapResponseFromJson(Map<String, dynamic> json) =>
    GeneralMapResponse(
      json['data'] as Map<String, dynamic>?,
      message: json['message'],
      status: json['status'] as int,
    );

Map<String, dynamic> _$GeneralMapResponseToJson(GeneralMapResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };
