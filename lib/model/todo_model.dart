
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? userId;
  String? title;
  String? description;
  bool? isDone;
  DateTime? dateCreated;
  DateTime? endDate;
  String? taskId;
  TodoModel({
    this.userId,
    this.title,
    this.description,
    this.isDone,
    this.dateCreated,
    this.endDate,
    this.taskId,
  });
  TodoModel.fromJson(Map<String, dynamic> jsondata) {
    userId = jsondata["userId"];
    title = jsondata["title"];
    description = jsondata["description"];
    isDone = jsondata["isDone"];
    dateCreated = (jsondata["dateCreated"] as Timestamp).toDate();
    endDate = (jsondata["endDate"] as Timestamp).toDate();
    taskId = jsondata["taskId"];
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "title": title,
      "description": description,
      "isDone": isDone,
      "dateCreated": dateCreated,
      "endDate": endDate,
      "taskId": taskId,
    };
  }
}