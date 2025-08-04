// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_schedule_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddScheduleStore on _AddScheduleStore, Store {
  late final _$inputAtom =
      Atom(name: '_AddScheduleStore.input', context: context);

  @override
  String get input {
    _$inputAtom.reportRead();
    return super.input;
  }

  @override
  set input(String value) {
    _$inputAtom.reportWrite(value, super.input, () {
      super.input = value;
    });
  }

  late final _$schedulesAtom =
      Atom(name: '_AddScheduleStore.schedules', context: context);

  @override
  ObservableList<ScheduleEntity> get schedules {
    _$schedulesAtom.reportRead();
    return super.schedules;
  }

  @override
  set schedules(ObservableList<ScheduleEntity> value) {
    _$schedulesAtom.reportWrite(value, super.schedules, () {
      super.schedules = value;
    });
  }

  late final _$tasksListAtom =
      Atom(name: '_AddScheduleStore.tasksList', context: context);

  @override
  List<ScheduleEntity> get tasksList {
    _$tasksListAtom.reportRead();
    return super.tasksList;
  }

  @override
  set tasksList(List<ScheduleEntity> value) {
    _$tasksListAtom.reportWrite(value, super.tasksList, () {
      super.tasksList = value;
    });
  }

  late final _$isSuccessAtom =
      Atom(name: '_AddScheduleStore.isSuccess', context: context);

  @override
  bool get isSuccess {
    _$isSuccessAtom.reportRead();
    return super.isSuccess;
  }

  @override
  set isSuccess(bool value) {
    _$isSuccessAtom.reportWrite(value, super.isSuccess, () {
      super.isSuccess = value;
    });
  }

  late final _$loadSuccessAtom =
      Atom(name: '_AddScheduleStore.loadSuccess', context: context);

  @override
  bool get loadSuccess {
    _$loadSuccessAtom.reportRead();
    return super.loadSuccess;
  }

  @override
  set loadSuccess(bool value) {
    _$loadSuccessAtom.reportWrite(value, super.loadSuccess, () {
      super.loadSuccess = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AddScheduleStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$fetchTasksAsyncAction =
      AsyncAction('_AddScheduleStore.fetchTasks', context: context);

  @override
  Future<void> fetchTasks(TaskInputEntity params) {
    return _$fetchTasksAsyncAction.run(() => super.fetchTasks(params));
  }

  late final _$saveTasksToPrefsAsyncAction =
      AsyncAction('_AddScheduleStore.saveTasksToPrefs', context: context);

  @override
  Future<void> saveTasksToPrefs(List<ScheduleEntity> tasks) {
    return _$saveTasksToPrefsAsyncAction
        .run(() => super.saveTasksToPrefs(tasks));
  }

  late final _$loadTasksFromPrefsAsyncAction =
      AsyncAction('_AddScheduleStore.loadTasksFromPrefs', context: context);

  @override
  Future<void> loadTasksFromPrefs() {
    return _$loadTasksFromPrefsAsyncAction
        .run(() => super.loadTasksFromPrefs());
  }

  late final _$deleteTaskAsyncAction =
      AsyncAction('_AddScheduleStore.deleteTask', context: context);

  @override
  Future<void> deleteTask(int index) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(index));
  }

  late final _$deleteTaskByIdAsyncAction =
      AsyncAction('_AddScheduleStore.deleteTaskById', context: context);

  @override
  Future<void> deleteTaskById(String taskId) {
    return _$deleteTaskByIdAsyncAction.run(() => super.deleteTaskById(taskId));
  }

  late final _$addTaskAsyncAction =
      AsyncAction('_AddScheduleStore.addTask', context: context);

  @override
  Future<void> addTask(List<ScheduleEntity> newTasks) {
    return _$addTaskAsyncAction.run(() => super.addTask(newTasks));
  }

  late final _$_AddScheduleStoreActionController =
      ActionController(name: '_AddScheduleStore', context: context);

  @override
  void setInput(String value) {
    final _$actionInfo = _$_AddScheduleStoreActionController.startAction(
        name: '_AddScheduleStore.setInput');
    try {
      return super.setInput(value);
    } finally {
      _$_AddScheduleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
input: ${input},
schedules: ${schedules},
tasksList: ${tasksList},
isSuccess: ${isSuccess},
loadSuccess: ${loadSuccess},
isLoading: ${isLoading}
    ''';
  }
}
