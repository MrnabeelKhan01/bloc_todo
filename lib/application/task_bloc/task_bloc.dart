// import 'package:bloc/bloc.dart';
// import 'package:bloc_todo/infrastructure/models/task.dart';
// import 'package:bloc_todo/infrastructure/services/task.dart';
// import 'package:meta/meta.dart';
//
// part 'task_event.dart';
//
// part 'task_state.dart';
//
// class TaskBloc extends Bloc<TaskEvent, TaskState> {
//   TaskBloc() : super(TaskInitial()) {
//     on<GetAllTasks>((event, emit)async {
//       if(event is GetAllTasks){
//         emit(getAllTask(event));
//       } else if(event is GetCompletedTasks){
//         emit(getCompletedTask(event));
//       }
//     });
//   }
//   getAllTask(TaskEvent event)async{
//     if (event is GetAllTasks) {
//       await TaskServices().getAllTasks(event.token.toString()).then((val) {
//         emit(TaskLoaded(val));
//         //emit is used to return the value
//       }).onError((e,_){
//         emit(TaskFailed(e.toString()));
//       });
//     }
//   }
//   getCompletedTask(TaskEvent event)async{
//     if (event is GetCompletedTasks) {
//       await TaskServices().getCompletedTasks(event.token.toString()).then((val) {
//         emit(TaskLoaded(val));
//         //emit is used to return the value
//       }).onError((e,_){
//         emit(TaskFailed(e.toString()));
//       });
//     }
//   }
// }
//
import 'package:bloc/bloc.dart';
import 'package:bloc_todo/infrastructure/models/task.dart';
import 'package:bloc_todo/infrastructure/services/task.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<GetAllTasks>((event, emit) async {
      await _handleGetAllTasks(event, emit);
    });

    on<GetCompletedTasks>((event, emit) async {
      await _handleGetCompletedTasks(event, emit);
    });
  }

  Future<void> _handleGetAllTasks(GetAllTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await TaskServices().getAllTasks(event.token.toString());
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskFailed(e.toString()));
    }
  }

  Future<void> _handleGetCompletedTasks(GetCompletedTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await TaskServices().getCompletedTasks(event.token.toString());
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskFailed(e.toString()));
    }
  }
}
