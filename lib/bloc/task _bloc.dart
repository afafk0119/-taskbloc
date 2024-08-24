import 'package:bloc_task/bloc/bloc_state.dart';
import 'package:bloc_task/data/model/localstorage.dart/localstorage.dart';
import 'package:bloc_task/data/model/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  TaskBloc() : super(TaskInitial()) {
    on<CreateTask>(_onCreateTask);
    on<LoadTasks>(_onLoadTasks);
  }

  Future<void> _onCreateTask(CreateTask event, Emitter<TaskState> emit) async {
    await _databaseHelper.insertTask(event.task);
    add(LoadTasks()); // Reload tasks after creation
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoadInProgress());
    try {
      final tasks = await _databaseHelper.getTasks();
      emit(TaskLoadSuccess(tasks));
    } catch (_) {
      emit(TaskLoadFailure('Failed to load tasks'));
    }
  }
}
