import 'package:bloc_todo/presentation/view/all_task/layout/body.dart';
import 'package:flutter/material.dart';

class AllTaskView extends StatelessWidget {
  const AllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:AllTaskBody(),
    );
  }
}
