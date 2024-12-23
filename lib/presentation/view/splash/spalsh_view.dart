import 'package:bloc_todo/presentation/view/bottom_navigation/bottom_nav_view.dart';
import 'package:bloc_todo/presentation/view/log_in/log_in_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../configs/backend_configs.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token != null && token.isNotEmpty) {
      BackendConfigs.kUserToken = token;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBarView()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogInView()),
      );
    }
  }


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      checkToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check, size: 100, color: Colors.indigo),
            SizedBox(height: 16),
            Text(
              'Welcome to Bloc Todo App',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
