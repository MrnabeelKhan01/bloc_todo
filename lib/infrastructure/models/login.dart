
import 'dart:convert';

LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
  String? token;
  String? message;
  bool? status;

  LogInModel({
    this.token,
    this.message,
    this.status,
  });

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
    token: json["token"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "message": message,
    "status": status,
  };
}
