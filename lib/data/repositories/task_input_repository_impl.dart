import 'package:fpdart/fpdart.dart';
import 'package:time_management_ai/data/datasources/remote/api/ai_api.dart';
import 'package:time_management_ai/utils/failure.dart';
import 'package:time_management_ai/domain/entities/schedule_entity.dart';
import 'package:time_management_ai/domain/entities/task_input_entity.dart';
import 'package:time_management_ai/domain/repositories/task_input_repository.dart';

class TaskInputRepositoryImpl implements TaskInputRepository {
  final AiApi _aiApi;

  TaskInputRepositoryImpl(this._aiApi);

  @override
  Future<Either<Failure, List<ScheduleEntity>>> parseTaskInput(
      TaskInputEntity params) async {
    return await _aiApi.processAiInputApi(params);
  }
}
