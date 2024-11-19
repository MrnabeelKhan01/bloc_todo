// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  List<Task> tasks;
  int totalPages;
  int currentPage;
  int count;

  TaskModel({
    required this.tasks,
    required this.totalPages,
    required this.currentPage,
    required this.count,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
    "totalPages": totalPages,
    "currentPage": currentPage,
    "count": count,
  };
}

class Task {
  String id;
  String description;
  bool complete;
  String owner;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Task({
    required this.id,
    required this.description,
    required this.complete,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["_id"],
    description: json["description"],
    complete: json["complete"],
    owner: json["owner"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description,
    "complete": complete,
    "owner": owner,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
