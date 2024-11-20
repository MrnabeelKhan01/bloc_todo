part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class GetAllTasks extends TaskEvent {
  final String token;

  GetAllTasks({required this.token});
}
class GetCompletedTasks extends TaskEvent {
  final String token;

  GetCompletedTasks({required this.token});
}
class GetInCompletedTasks extends TaskEvent {
  final String token;

  GetInCompletedTasks({required this.token});
}
