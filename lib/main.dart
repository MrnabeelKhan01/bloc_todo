import 'package:bloc_todo/application/task_bloc/task_bloc.dart';
import 'package:bloc_todo/presentation/view/all_task/all_task_view.dart';
import 'package:flutter/material.dart';

import 'presentation/view/all_task/completed_task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const CompletedTask(),
    );
  }
}
