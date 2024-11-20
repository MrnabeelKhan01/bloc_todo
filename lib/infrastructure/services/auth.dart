import 'dart:convert';

import 'package:bloc_todo/infrastructure/models/login.dart';
import 'package:http/http.dart'as http;

class AuthServices{
  Future<LogInModel> loginUser(
      {required String email, required String password}) async {
    http.Response response = await http.post(
        Uri.parse(
          'https://todo-nu-plum-19.vercel.app/users/login',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LogInModel.fromJson(jsonDecode(response.body));
    } else {
      return LogInModel();
    }
  }

}