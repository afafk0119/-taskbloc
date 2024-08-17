import 'package:bloc_task/bloc/bloc_state.dart';
import 'package:bloc_task/data/model/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<CreateTask>(_onCreateTask);
  }

  void _onCreateTask(CreateTask event, Emitter<TaskState> emit) {
    if (state is TaskLoadSuccess) {
      final List<Task> updatedTasks =
          List.from((state as TaskLoadSuccess).tasks)..add(event.task);
      emit(TaskLoadSuccess(updatedTasks));
    } else {
      emit(TaskLoadSuccess([event.task]));
    }
  }
}
