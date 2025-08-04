// lib/domain/entities/task_entity.dart
import 'package:json_annotation/json_annotation.dart';

part 'task_entity.g.dart';

@JsonSerializable()
class TaskEntity {
  @JsonKey(name: 'time')
  final String time;
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'description')
  final String description;

  bool isCompleted;
  TaskEntity({
    required this.time,
    required this.description,
    required this.id,
    this.isCompleted = false,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);
}
