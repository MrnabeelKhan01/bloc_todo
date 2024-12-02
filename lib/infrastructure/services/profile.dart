import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc_todo/infrastructure/models/profile.dart';

import '../../configs/backend_configs.dart';
import '../../configs/end_points.dart';
import '../models/task.dart';
import 'package:http/http.dart' as http;

class ProfileServices {
  ///Get User Profile
  Future<ProfileModel> getUserProfile() async {
    try {
      final response = await http.get(
          Uri.parse(
            BackendConfigs.kBaseUrl + EndPoints.kGetProfile,
          ),
          headers: {'Authorization': BackendConfigs.kUserToken});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log('object ${response.statusCode}');
        log('Response Data: $data');
        return ProfileModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch profile: ${response.reasonPhrase}');
      }
    } on SocketException {
      throw Exception('Network Issue');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///Edit User Profile
  Future<bool> editUserProfile({
    required String name,
  }) async {
    try {
      final response = await http.put(
          Uri.parse(
            BackendConfigs.kBaseUrl + EndPoints.kGetProfile,
          ),
          headers: {
            'Authorization': BackendConfigs.kUserToken,
            'Content-Type': 'application/json'
          },
          body: json.encode({"name": name}));

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
}
