import 'dart:convert';


import 'package:http/http.dart'as http;

import '../../configs/backend_configs.dart';
import '../../configs/end_points.dart';
import '../models/task.dart';


class   GetServices{
  Future<List<TaskModel>> getAllTasks() async {
    final response = await http.get(
      Uri.parse(
        BackendConfigs.kBaseUrl + EndPoints.kGetAllTasks,
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body); // Decode JSON array
      return data.map((json) => TaskModel.fromJson(json)).toList(); // Map to List<TaskModel>
    } else {
      throw Exception('Failed to fetch tasks: ${response.reasonPhrase}');
    }
  }


}