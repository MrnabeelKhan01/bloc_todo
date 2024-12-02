import 'package:bloc_todo/application/task_bloc/task_bloc.dart';
import 'package:bloc_todo/infrastructure/models/task.dart';
import 'package:bloc_todo/presentation/elements/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../configs/backend_configs.dart';
import '../create_task/create_task_view.dart';

class InCompletedTask extends StatelessWidget {
  InCompletedTask({super.key});

  TaskModel? model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TaskBloc(),
        child: BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is TaskDeleted) {
              BlocProvider.of<TaskBloc>(context)
                  .add(GetAllTasks(token: BackendConfigs.kUserToken));
            } else if (state is TaskFailed) {
              CustomText(text: state.message.toString());
            }
          },
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskInitial) {
                BlocProvider.of<TaskBloc>(context)
                    .add(GetAllTasks(token: BackendConfigs.kUserToken));
                return const Center(child: CircularProgressIndicator());
              } else if (state is TaskLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TaskLoaded) {
                model = state.model;
                return state.model.tasks!.isEmpty
                    ? Center(child: CustomText(text: 'No Data Found'))
                    : LoadingOverlay(
                        isLoading: state is TaskLoading,
                        child: ListView.builder(
                            itemCount: state.model.tasks!.length,
                            itemBuilder: (context, i) {
                              return ListTile(
                                title: CustomText(
                                    text: state.model.tasks![i].description
                                        .toString()),
                                trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      BlocProvider.of<TaskBloc>(context).add(
                                          DeleteTasksEvent(
                                              docID: state.model.tasks![i].id
                                                  .toString(),
                                              token:
                                                  BackendConfigs.kUserToken));
                                    }),
                              );
                            }),
                      );
              } else if (state is TaskFailed) {
                return CustomText(text: state.message);
              } else {
                return CustomText(text: "Something went wrong");
              }
            },
          ),
        ),
      ),
    );
  }
}
