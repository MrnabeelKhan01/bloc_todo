import 'dart:convert';

import 'package:bloc_todo/infrastructure/models/login.dart';
import 'package:http/http.dart' as http;

import '../../configs/backend_configs.dart';
import '../../configs/end_points.dart';
import '../models/sign_up.dart';

class AuthServices {
  Future<LogInModel> loginUser(
      {required String email, required String password}) async {
    http.Response response = await http.post(
      Uri.parse(BackendConfigs.kBaseUrl + EndPoints.kLogInUser),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return LogInModel.fromJson(jsonDecode(response.body));
    } else {
      final responseBody = jsonDecode(response.body);
      return LogInModel(
        status: false,
        message: '',
      );
    }
  }

  Future<SignUpModel> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    http.Response response = await http.post(
      Uri.parse(BackendConfigs.kBaseUrl + EndPoints.kRegisterUser),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return SignUpModel.fromJson(jsonDecode(response.body));
    } else {
      final responseBody = jsonDecode(response.body);
      return SignUpModel(
        status: false,
        error: responseBody['error'] ?? 'Unknown error occurred',
      );
    }
  }
}
