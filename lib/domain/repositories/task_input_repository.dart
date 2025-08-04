import 'package:fpdart/fpdart.dart';
import 'package:time_management_ai/domain/entities/failure.dart';
import 'package:time_management_ai/domain/entities/schedule_entity.dart';
import 'package:time_management_ai/domain/entities/task_input_entity.dart';

abstract class TaskInputRepository {
  Future<Either<Failure, List<ScheduleEntity>>> parseTaskInput(
      TaskInputEntity params);
}
