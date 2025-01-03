import 'package:bloc_todo/application/task_bloc/task_bloc.dart';
import 'package:bloc_todo/configs/backend_configs.dart';
import 'package:bloc_todo/presentation/elements/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedTask extends StatelessWidget {
  const CompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TaskBloc(),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskInitial) {
              BlocProvider.of<TaskBloc>(context).add(GetCompletedTasks(
                  token:
                      BackendConfigs.kUserToken));
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskLoaded) {
              return state.model.tasks!.isEmpty
                  ? const Center(
                child: Text("No Data Found"),
              )
                  :  ListView.builder(
                  itemCount: state.model.tasks!.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: CustomText(
                          text: state.model.tasks![i].description.toString()),
                    );
                  });
            } else if (state is TaskFailed) {
              return CustomText(text: state.message);
            }else{
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ),
      ),
    );
  }
}
