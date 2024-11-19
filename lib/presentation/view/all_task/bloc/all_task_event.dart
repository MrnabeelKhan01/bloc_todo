
part of 'all_task_bloc.dart';


abstract class AllTaskEvent  {
  final bool isRefresh;

  const AllTaskEvent(this.isRefresh);

  @override
  List<Object> get props => [];
}

class GetAllTaskData extends AllTaskEvent {
  const GetAllTaskData(super.isRefresh);
}

