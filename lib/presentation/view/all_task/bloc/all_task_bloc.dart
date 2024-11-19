import 'package:bloc_todo/infrastructure/services/get_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../infrastructure/models/task.dart';

part 'all_task_state.dart';
part 'all_task_event.dart';

class AllTaskBloc extends Bloc<AllTaskEvent, AllTaskState> {
  final GetServices getServices;

  AllTaskBloc(this.getServices) : super(AllTaskStateInitial()) {
    on<GetAllTaskData>(_onGetAllTaskData);
  }

  Future<void> _onGetAllTaskData(
      GetAllTaskData event, Emitter<AllTaskState> emit) async {
    try {
      emit(AllTaskStateLoading());
      final taskModel = await getServices.getAllTasks(
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM1YWVjMzRjZTRmNDBjNWFiNzljYzIiLCJpYXQiOjE3MzIwMDgxNDN9.xZipKMKtyWYbBd-U4Vr7kTCCX6fCbnHazE7njRrFFro');
      emit(AllTaskStateLoaded(taskModel));  // Send TaskModel instead of List<TaskModel>
    } catch (e) {
      emit(AllTaskStateFailed("Failed to fetch tasks: ${e.toString()}"));
      print(e.toString());
    }
  }
}

