import 'package:fpdart/fpdart.dart';
import 'package:time_management_ai/domain/entities/schedule_entity.dart';
import 'package:time_management_ai/domain/entities/failure.dart';
import 'package:time_management_ai/domain/entities/task_input_entity.dart';
import 'package:time_management_ai/domain/repositories/task_input_repository.dart';

class TaskInputUseCase {
  final TaskInputRepository repository;

  TaskInputUseCase(this.repository);

  Future<Either<Failure, List<ScheduleEntity>>> call(
      {required TaskInputEntity params}) async {
    return await repository.parseTaskInput(params);
  }
}
