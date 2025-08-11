import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_management_ai/domain/entities/schedule_entity.dart';
import 'package:time_management_ai/domain/entities/task_entity.dart';
import 'package:time_management_ai/domain/entities/task_input_entity.dart';
import 'package:time_management_ai/domain/usecases/task_input_usecase.dart';

part 'add_schedule_store.g.dart';

class AddScheduleStore = _AddScheduleStore with _$AddScheduleStore;

abstract class _AddScheduleStore with Store {
  final TaskInputUseCase _taskInputUseCase;

  _AddScheduleStore(this._taskInputUseCase);

  static const _storageKey = 'saved_tasks';

  @observable
  String input = '';

  @observable
  ObservableList<ScheduleEntity> schedules = ObservableList<ScheduleEntity>();

  @observable
  List<ScheduleEntity> tasksList = [];

  @observable
  bool isSuccess = false;

  @observable
  bool loadSuccess = false;

  @observable
  bool isLoading = false;


  @action
  Future<void> fetchTasks(TaskInputEntity params) async {
    isLoading = true;
    final result = await _taskInputUseCase.call(params: params);
    result.fold(
      (failure) => print('Error: ${failure.error}'),
      (data) => schedules = ObservableList.of(data),
    );
    isLoading = false;

  }

  @action
  Future<void> saveTasksToPrefs(List<ScheduleEntity> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskJsonList = tasks.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_storageKey, taskJsonList);
    isSuccess = true;
  }

  @action
  Future<void> loadTasksFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList(_storageKey);
    if (savedList != null) {
      final tasks = savedList
          .map((e) => ScheduleEntity.fromJson(json.decode(e)))
          .toList();
      tasksList = tasks;
    }
    loadSuccess = true;
  }

  @action
  Future<void> deleteTask(String title) async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList(_storageKey) ?? [];

    final decodedList =
        savedList.map((e) => ScheduleEntity.fromJson(json.decode(e))).toList();

    final indexToRemove = decodedList.indexWhere((item) => item.title == title);

    if (indexToRemove != -1) {
      savedList.removeAt(indexToRemove);

      await prefs.setStringList(_storageKey, savedList);

      tasksList = decodedList..removeAt(indexToRemove);
    } else {
      print('Không tìm thấy task với title: $title');
    }
  }

  @action
  Future<void> deleteTaskById(String taskId) async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList(_storageKey);

    if (savedList != null) {
      final updatedScheduleList = savedList.map((jsonString) {
        final schedule = ScheduleEntity.fromJson(json.decode(jsonString));

        final filteredTasks =
            schedule.tasks.where((task) => task.id != taskId).toList();

        return ScheduleEntity(
          title: schedule.title,
          date: schedule.date,
          tasks: filteredTasks,
          id: schedule.id,
        );
      }).toList();

      final updatedJsonList = updatedScheduleList
          .map((schedule) => jsonEncode(schedule.toJson()))
          .toList();

      await prefs.setStringList(_storageKey, updatedJsonList);

      tasksList = updatedScheduleList;
    }
  }

  @action
  Future<void> addTask(List<ScheduleEntity> newTasks) async {
    final prefs = await SharedPreferences.getInstance();

    final savedList = prefs.getStringList(_storageKey) ?? [];

    final newTaskJsonList =
        newTasks.map((e) => jsonEncode(e.toJson())).toList();

    final updatedList = [...savedList, ...newTaskJsonList];

    // Lưu
    await prefs.setStringList(_storageKey, updatedList);

    // Cập nhật
    tasksList = updatedList
        .map((e) => ScheduleEntity.fromJson(json.decode(e)))
        .toList();
    isSuccess = true;
  }

  @action
  Future<void> updateTaskCompletion(String taskId, bool isCompleted) async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList(_storageKey);

    if (savedList != null) {
      final updatedScheduleList = savedList.map((jsonString) {
        final schedule = ScheduleEntity.fromJson(json.decode(jsonString));

        final updatedTasks = schedule.tasks.map((task) {
          if (task.id == taskId) {
            return TaskEntity(
              id: task.id,
              time: task.time,
              description: task.description,
              isCompleted: isCompleted, 
            );
          }
          return task;
        }).toList();

        return ScheduleEntity(
          title: schedule.title,
          date: schedule.date,
          tasks: updatedTasks,
          id: schedule.id,
        );
      }).toList();

      final updatedJsonList = updatedScheduleList
          .map((schedule) => jsonEncode(schedule.toJson()))
          .toList();

      await prefs.setStringList(_storageKey, updatedJsonList);

      tasksList = updatedScheduleList;
    }
  }
}
