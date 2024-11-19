import 'package:bloc_todo/infrastructure/services/get_services.dart';
import 'package:bloc_todo/presentation/view/all_task/bloc/all_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllTaskBody extends StatelessWidget {
  const AllTaskBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AllTaskBloc(GetServices())..add(const GetAllTaskData(false)),
      child: BlocBuilder<AllTaskBloc, AllTaskState>(builder: (context, state) {
        if (state is AllTaskStateLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.purple),
          );
        } else if (state is AllTaskStateLoaded) {
          return ListView.builder(
            itemCount: state.tasks.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks.tasks[index];
              return ListTile(
                title: Text(task.description ?? "No Description")
              );
            },
          );
        } else if (state is AllTaskStateFailed) {
          return Center(
            child: Text("Error: ${state.message}"),
          );
        }
        return const Center(
          child: Text("No Data"),
        );
      }),
    );
  }
}

