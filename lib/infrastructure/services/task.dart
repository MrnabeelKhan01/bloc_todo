import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../../configs/backend_configs.dart';
import '../../configs/end_points.dart';
import '../models/task.dart';
import 'package:http/http.dart' as http;

class TaskServices {
  ///Get All Tasks
  Future<TaskModel> getAllTasks(String token) async {
    try {
      final response = await http.get(
          Uri.parse(
            BackendConfigs.kBaseUrl + EndPoints.kGetAllTasks,
          ),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log('object ${response.statusCode}');
        log('Response Data: $data');
        return TaskModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch tasks: ${response.reasonPhrase}');
      }
    } on SocketException {
      throw Exception('Network Issue');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///Get Completed Tasks
  Future<TaskModel> getCompletedTasks(String token) async {
    try {
      final response = await http.get(
          Uri.parse(
            BackendConfigs.kBaseUrl + EndPoints.kGetCompletedTasks,
          ),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log('object ${response.statusCode}');
        log('Response Data: $data');
        return TaskModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch tasks: ${response.reasonPhrase}');
      }
    } on SocketException {
      throw Exception('Network Issue');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  ///Get InCompleted Tasks
  Future<TaskModel> getInCompletedTasks(String token) async {
    try {
      final response = await http.get(
          Uri.parse(
            BackendConfigs.kBaseUrl + EndPoints.kGetInCompletedTasks,
          ),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log('object ${response.statusCode}');
        log('Response Data: $data');
        return TaskModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch tasks: ${response.reasonPhrase}');
      }
    } on SocketException {
      throw Exception('Network Issue');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
