import 'package:get_it/get_it.dart';
import 'package:time_management_ai/data/datasources/remote/api/ai_api.dart';
import 'package:time_management_ai/data/repositories/task_input_repository_impl.dart';
import 'package:time_management_ai/domain/repositories/task_input_repository.dart';
import 'package:time_management_ai/domain/usecases/task_input_usecase.dart';
import 'package:time_management_ai/presentation/stores/add_schedule_store.dart';

final getIt = GetIt.instance;

mixin ServiceLocator {
  static Future<void> configureDependencies() async {
    // Đăng ký API gọi đến OpenAI

    getIt.registerLazySingleton<AiApi>(() => AiApi());
    // Đăng ký Repository
    getIt.registerLazySingleton<TaskInputRepository>(
        () => TaskInputRepositoryImpl(getIt<AiApi>()));


    

    // Đăng ký UseCase
    getIt.registerSingleton(
        () => TaskInputUseCase(getIt<TaskInputRepository>()));
    getIt.registerFactory(() => AddScheduleStore(getIt()));
    getIt.registerFactory(() => TaskInputUseCase(getIt()));

    // Đăng ký Store
    getIt.registerSingleton(() => AddScheduleStore(getIt<TaskInputUseCase>()));
  }
}
