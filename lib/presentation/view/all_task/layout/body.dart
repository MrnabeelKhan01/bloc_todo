import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../configs/backend_configs.dart';
import '../../../elements/custom_text.dart';
import '../../../../application/task_bloc/task_bloc.dart';

class AllTaskBody extends StatelessWidget {
  const AllTaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is EditTask) {
            BlocProvider.of<TaskBloc>(context)
                .add(GetAllTasks(token: BackendConfigs.kUserToken));
          } else if (state is TaskFailed) {
            CustomText(text: state.message.toString());
          }
        },
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskInitial) {
              BlocProvider.of<TaskBloc>(context).add(GetAllTasks(
                  token: BackendConfigs.kUserToken));
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskLoaded) {
              return state.model.tasks!.isEmpty
                  ? const Center(
                child: Text("No Data Found"),
              )
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
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showEditDialog(
                              context: context,
                              taskId: state.model.tasks![i].id.toString(),
                              initialDescription: state
                                  .model.tasks![i].description
                                  .toString(),
                              initialComplete: state
                                  .model.tasks![i].complete!,
                              bloc: BlocProvider.of<TaskBloc>(context),
                            );
                          },
                        ),
                      );
                    }),
              );
            } else if (state is TaskFailed) {
              return Center(
                child: Text(state.message.toString()),
              );
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ),
      ),
    );
  }

  void showEditDialog({
    required BuildContext context,
    required String taskId,
    required String initialDescription,
    required bool initialComplete,
    required TaskBloc bloc,
  }) {
    final TextEditingController descriptionController =
    TextEditingController(text: initialDescription);
    bool isComplete = initialComplete;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<bool>(
                value: isComplete,
                decoration: const InputDecoration(
                  labelText: "Status",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: true,
                    child: Text("Complete"),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text("Incomplete"),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    isComplete = value;
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                bloc.add(
                  EditTasksEvent(
                    docID: taskId,
                    description: descriptionController.text.trim(),
                    isComplete: isComplete,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
