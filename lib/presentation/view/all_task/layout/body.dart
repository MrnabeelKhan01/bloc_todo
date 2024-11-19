import 'package:bloc_todo/infrastructure/services/get_services.dart';
import 'package:bloc_todo/presentation/view/all_task/bloc/all_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllTaskBody extends StatelessWidget {
  const AllTaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
            create: (_) => AllTaskBloc(GetServices()),
        child: BlocListener<AllTaskBloc, AllTaskState>(
          listener: (context, state) {},
          child: BlocBuilder<AllTaskBloc, AllTaskState>(
              builder: (context, state) {
                if (state is AllTaskStateInitial) {
                  BlocProvider.of<AllTaskBloc>(context).add(
                      const GetAllTaskData(false));
                  return const CircularProgressIndicator(
                    color:Colors.purple,
                  );
                } else if (state is AllTaskStateLoading) {
                  return const CircularProgressIndicator(
                    color:Colors.purple,
                  );
                } else if (state is AllTaskStateLoaded) {
                  return ListView.builder(itemBuilder: (context, i) {
                    return Row(children: [
                      Text(state.model.tasks![i].description.toString())
                    ],);
                  });

                }
                return Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Center(child: Text("Error")),
                  ],
                );
              }
              ),
        )
    );
  }
}
