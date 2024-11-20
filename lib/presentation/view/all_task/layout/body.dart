import 'package:bloc_todo/application/task_bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllTaskBody extends StatelessWidget {
  const AllTaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskInitial) {
            BlocProvider.of<TaskBloc>(context).add(GetAllTasks(
                token:
                    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NzNiMTYwODY1OGZkMmIzNjZmOWZhZDkiLCJpYXQiOjE3MzIwODY1NDV9.HcM0UMHhW7axlE3U3s2_x0ecnp7ldBPiJHOQOb8Ncu8'));
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            return state.model.tasks!.isEmpty
                ? const Center(
                    child: Text("No Data Found"),
                  )
                : ListView.builder(
                    itemCount: state.model.tasks!.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title:
                            Text(state.model.tasks![i].description.toString()),
                        leading: const Icon(Icons.task),
                      );
                    });
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
    );
  }
}
