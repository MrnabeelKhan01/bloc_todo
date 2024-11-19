


import 'package:bloc_todo/infrastructure/services/get_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../infrastructure/models/task.dart';


part 'all_task_state.dart';
part 'all_task_event.dart';

class AllTaskBloc extends Bloc<AllTaskEvent, AllTaskState>{
  final GetServices getServices;
  AllTaskBloc(this.getServices) : super(AllTaskStateInitial()) {
    on<AllTaskEvent>((event, emit) async {

      try{
        emit(AllTaskStateLoading());
        if(event.isRefresh==true){
          GetServices().getAllTasks();
          emit(AllTaskStateLoaded(TaskModel()));
        }else{
         emit(AllTaskStateFailed("Error"));

        }
      } catch(e){
        e.toString();
      }
      // TODO: implement event handler
    });
  }
}
