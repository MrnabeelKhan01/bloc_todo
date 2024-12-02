import 'package:bloc_todo/configs/backend_configs.dart';
import 'package:bloc_todo/presentation/view/bottom_navigation/bottom_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../application/auth_bloc/auth_bloc.dart';

class LogInView extends StatelessWidget {
  final TextEditingController emailController =
  TextEditingController(text: 'kk12@gmail.com');
  final TextEditingController passwordController =
  TextEditingController(text: '123456');

  LogInView({super.key});

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    BackendConfigs.kUserToken = prefs.getString('authToken')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is LogInLoaded) {
              EasyLoading.dismiss();
              await saveToken(state.logInModel.token.toString()); // Save token
              EasyLoading.showSuccess(
                state.logInModel.message.toString(),
              ).then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomNavBarView()),
                    (route) => false,
              ));
            } else if (state is LogInFailed) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.logInModel.message.toString());
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        EasyLoading.show(status: 'Logging...');
                        BlocProvider.of<AuthBloc>(context).add(
                          LogInEvent(
                            email: emailController.text,
                            password: passwordController.text.trim(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text('Log In'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
