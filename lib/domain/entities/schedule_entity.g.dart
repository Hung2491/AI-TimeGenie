// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleEntity _$ScheduleEntityFromJson(Map<String, dynamic> json) =>
    ScheduleEntity(
      id: json['id'] as String?,
      title: json['title'] as String,
      date: ScheduleEntity._fromJsonDate(json['date'] as String),
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => TaskEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleEntityToJson(ScheduleEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'date': ScheduleEntity._toJsonDate(instance.date),
      'tasks': instance.tasks,
    };
