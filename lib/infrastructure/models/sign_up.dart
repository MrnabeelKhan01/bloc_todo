// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  User? user;
  String? message; // For general success messages
  bool? status;    // Indicates whether the request was successful
  String? error;   // For error messages when registration fails

  SignUpModel({
    this.user,
    this.message,
    this.status,
    this.error,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    message: json["message"],
    status: json["status"],
    error: json["error"], // Parse the error field from JSON
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "message": message,
    "status": status,
    "error": error,
  };
}

class User {
  String? name;
  String? email;
  String? password;
  String? id;
  int? v;

  User({
    this.name,
    this.email,
    this.password,
    this.id,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "_id": id,
    "__v": v,
  };
}
