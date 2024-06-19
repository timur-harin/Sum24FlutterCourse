// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_status_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CatStatusCodeImpl _$$CatStatusCodeImplFromJson(Map<String, dynamic> json) =>
    _$CatStatusCodeImpl(
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$$CatStatusCodeImplToJson(_$CatStatusCodeImpl instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
    };
