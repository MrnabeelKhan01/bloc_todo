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

  ///Delete Tasks
  Future<bool> deleteTasks(
      {required String token, required String docID}) async {
    try {
      final response = await http.delete(
          Uri.parse(
            BackendConfigs.kBaseUrl + EndPoints.kDeleteTask + docID,
          ),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      throw Exception('Network Issue');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///Delete Tasks
  Future<bool> editTasks({
    required String docID,
    required String description,
    required bool isComplete,
  }) async {
    try {
      final response = await http.patch(
          Uri.parse(
            BackendConfigs.kBaseUrl + EndPoints.kEditTask + docID,
          ),
          headers: {
            'Authorization': BackendConfigs.kUserToken,
            'Content-Type': 'application/json'
          },
          body: json
              .encode({"description": description, "complete": isComplete}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      throw Exception('Network Issue');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Task Created
  Future<Task> createTasks({required String description}) async {
    try {
      final response = await http.post(
          Uri.parse(
            BackendConfigs.kBaseUrl + EndPoints.kAddTask,
          ),
          headers: {
            'Authorization': BackendConfigs.kUserToken,
            'Content-Type': 'application/json'
          },
          body: json.encode({"description": description}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('message %${response.statusCode}');
        return Task.fromJson(jsonDecode(response.body)['task']);
      } else {
        log('message %${response.reasonPhrase}');
        throw Exception('Failed to fetch tasks: ${response.reasonPhrase}');
      }
    } on SocketException {
      throw Exception('Network Issue');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
