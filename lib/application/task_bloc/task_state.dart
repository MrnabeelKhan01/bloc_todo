part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final TaskModel model;
  TaskLoaded(this.model);
}

class TaskDeleted extends TaskState {
  TaskDeleted();
}
class EditTask extends TaskState {
  EditTask();
}

class TaskCreated extends TaskState {
  TaskCreated();
}

class TaskFailed extends TaskState {
  final String message;

  TaskFailed(this.message);
}
