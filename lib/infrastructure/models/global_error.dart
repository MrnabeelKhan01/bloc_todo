
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

GlobalErrorModel globalErrorModelFromJson(String str) =>
    GlobalErrorModel.fromJson(json.decode(str));

String globalErrorModelToJson(GlobalErrorModel data) =>
    json.encode(data.toJson());

class GlobalErrorModel {
  final String? error;

  GlobalErrorModel({
    this.error,
  });

  factory GlobalErrorModel.fromJson(Map<String, dynamic> json) =>
      GlobalErrorModel(
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}

