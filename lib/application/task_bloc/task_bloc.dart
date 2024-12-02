import 'package:bloc/bloc.dart';
import 'package:bloc_todo/infrastructure/models/task.dart';
import 'package:bloc_todo/infrastructure/services/task.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<GetAllTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await TaskServices().getAllTasks(event.token.toString());
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskFailed(e.toString()));
      }
    });

    // Handle getting completed tasks
    on<GetCompletedTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks =
            await TaskServices().getCompletedTasks(event.token.toString());
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskFailed(e.toString()));
      }
    });

    // Handle getting incomplete tasks
    on<GetInCompletedTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks =
            await TaskServices().getInCompletedTasks(event.token.toString());
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskFailed(e.toString()));
      }
    });

    // Handle deleting a task
    on<DeleteTasksEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        await TaskServices().deleteTasks(
          token: event.token.toString(),
          docID: event.docID,
        );
        emit(TaskDeleted());
      } catch (e) {
        emit(TaskFailed(e.toString()));
      }
    });

    // Handle Edit a task
    on<EditTasksEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        await TaskServices().editTasks(
          docID: event.docID,
          description: event.description,
          isComplete: event.isComplete
        );
        emit(EditTask());
      } catch (e) {
        emit(TaskFailed(e.toString()));
      }
    });

    // Handle creating a task
    on<CreateTasksEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        await TaskServices().createTasks(
          description: event.description,
        );
        emit(TaskCreated());
      } catch (e) {
        emit(TaskFailed(e.toString()));
      }
    });
  }
}
