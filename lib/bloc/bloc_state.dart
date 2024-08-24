import 'package:bloc_task/data/model/task_model.dart';
import 'package:equatable/equatable.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoadInProgress extends TaskState {}

class TaskLoadSuccess extends TaskState {
  final List<Task> tasks;

  const TaskLoadSuccess([this.tasks = const []]);

  @override
  List<Object> get props => [tasks];
}

class TaskLoadFailure extends TaskState {
  final String error;

  const TaskLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
