// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TODOImpl _$$TODOImplFromJson(Map<String, dynamic> json) => _$TODOImpl(
      userId: (json['userId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      completed: json['completed'] as bool?,
    );

Map<String, dynamic> _$$TODOImplToJson(_$TODOImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'completed': instance.completed,
    };
