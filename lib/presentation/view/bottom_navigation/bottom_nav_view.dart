import 'dart:developer';

import 'package:bloc_todo/presentation/elements/custom_text.dart';
import 'package:bloc_todo/presentation/view/all_task/all_task_view.dart';
import 'package:bloc_todo/presentation/view/all_task/completed_task.dart';
import 'package:bloc_todo/presentation/view/all_task/incompleted_task.dart';
import 'package:flutter/material.dart';

import '../../../configs/backend_configs.dart';
import '../create_task/create_task_view.dart';
import '../profile/profile/profile_view.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView>
    with SingleTickerProviderStateMixin {
  int mainIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateTaskView()));
          },
        ),
        body: mainIndex == 0
            ? Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffF0F0F0),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: const Color(0xff431793),
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: const Color(0xffD8D2D4),
                onTap: (value) {
                  log('object123213${BackendConfigs.kUserToken}');
                },
                tabs:  [
                  Tab(
                    child: CustomText(
                      text: 'All',
                      fontSize: 12,
                    ),
                  ),
                  Tab(
                    child: CustomText(
                      text: 'Completed',
                      fontSize: 12,
                    ),
                  ),
                  Tab(
                    child: CustomText(
                      text: 'Incomplete',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:  [
                  const AllTaskView(),
                  const CompletedTask(),
                  InCompletedTask(),
                ],
              ),
            ),
          ],
        )
            : const ProfileScreen(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: mainIndex,
          onTap: (value) {
            setState(() {
              mainIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
