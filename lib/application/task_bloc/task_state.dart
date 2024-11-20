part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final TaskModel model;

  TaskLoaded(this.model);
}

class TaskFailed extends TaskState {
  final String message;

  TaskFailed(this.message);
}
