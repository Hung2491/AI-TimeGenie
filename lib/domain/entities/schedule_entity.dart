import 'package:json_annotation/json_annotation.dart';
import 'package:time_management_ai/domain/entities/task_entity.dart';

part 'schedule_entity.g.dart';

@JsonSerializable()
class ScheduleEntity {
  @JsonKey(name: 'title')
  final String title;

  @JsonKey(
    name: 'date',
    fromJson: _fromJsonDate,
    toJson: _toJsonDate,
  )
  final DateTime date;

  @JsonKey(name: 'tasks')
  final List<TaskEntity> tasks;

  ScheduleEntity({
    required this.title,
    required this.date,
    required this.tasks,
  });

  factory ScheduleEntity.fromJson(Map<String, dynamic> json) =>
      _$ScheduleEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleEntityToJson(this);

  /// Convert from "dd/MM/yyyy" string to DateTime
  static DateTime _fromJsonDate(String date) {
    final parts = date.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  /// Convert DateTime to "dd/MM/yyyy" string
  static String _toJsonDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}
