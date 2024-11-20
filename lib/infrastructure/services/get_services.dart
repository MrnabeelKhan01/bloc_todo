import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../configs/backend_configs.dart';
import '../../configs/end_points.dart';
import '../models/task.dart';

class GetServices {
  Future<TaskModel> getAllTasks(String token) async {
    final response = await http.get(
        Uri.parse(
          BackendConfigs.kBaseUrl + EndPoints.kGetAllTasks,
        ),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print('object ${response.statusCode}');
      print('Response Data: $data');
      return TaskModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch tasks: ${response.reasonPhrase}');
    }
  }
}