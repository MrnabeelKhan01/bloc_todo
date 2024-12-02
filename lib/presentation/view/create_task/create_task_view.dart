import 'dart:developer';

import 'package:bloc_todo/presentation/elements/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../application/task_bloc/task_bloc.dart';
import '../../../configs/backend_configs.dart';
import '../bottom_navigation/bottom_nav_view.dart';

class CreateTaskView extends StatelessWidget {
  CreateTaskView({super.key});

  TextEditingController controller = TextEditingController();
  String token = BackendConfigs.kUserToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: 'Created Task')),
      body: BlocProvider(
        create: (context) => TaskBloc(),
        child: BlocListener<TaskBloc, TaskState>(
          listener: (context, state) async {
            if (state is TaskLoaded) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess(
                'Tasks Created',
              ).then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomNavBarView()),
                    (route) => false,
              ));
            } else if (state is TaskFailed) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.message.toString());
            }
          },
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: controller,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          state is TaskLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<TaskBloc>(context).add(
                                    CreateTasksEvent(
                                      description:
                                      controller.text.toString(),
                                    ));
                              },
                              child: CustomText(text: 'Create Task')),
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<TaskBloc>(context).add(
                                    CreateTasksEvent(
                                      description: controller.text,
                                    ));
                              },
                              child: CustomText(text: 'Search Task')),
                        ],
                      )
                    ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
