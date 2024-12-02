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

class DeleteTasksEvent extends TaskEvent {
  final String token;
  final String docID;

  DeleteTasksEvent({
    required this.docID,
    required this.token,
  });
}

class EditTasksEvent extends TaskEvent {
  final String description;
  final String docID;
  final bool isComplete;

  EditTasksEvent({
    required this.docID,
    required this.description,
    required this.isComplete,
  });
}

class CreateTasksEvent extends TaskEvent {
  final String description;

  CreateTasksEvent({
    required this.description,
  });
}
