import 'package:bloc_task/data/model/task_model.dart';
import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class CreateTask extends TaskEvent {
  final Task task;

  const CreateTask(this.task);

  @override
  List<Object> get props => [task];
}

class LoadTasks extends TaskEvent {}
