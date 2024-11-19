



part of 'all_task_bloc.dart';

abstract class AllTaskState  {
   AllTaskState();

  @override
  List<Object> get props => [];
}

class AllTaskStateInitial extends AllTaskState {}

class AllTaskStateLoading extends AllTaskState {}

class AllTaskStateLoaded extends AllTaskState {
  final TaskModel model;

   AllTaskStateLoaded(this.model);
}

class AllTaskStateFailed extends AllTaskState{
  final String message;

   AllTaskStateFailed(this.message);
}
