import 'package:bloc_todo/application/task_bloc/task_bloc.dart';
import 'package:bloc_todo/presentation/view/all_task/all_task_view.dart';
import 'package:bloc_todo/presentation/view/all_task/incompleted_task.dart';
import 'package:bloc_todo/presentation/view/sign_up/sign_up_view.dart';
import 'package:bloc_todo/presentation/view/splash/spalsh_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'presentation/view/all_task/completed_task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
