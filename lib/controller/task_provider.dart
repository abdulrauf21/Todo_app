import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/local_data_source/user_local_data_source.dart';

class TaskProvider extends ChangeNotifier {
  bool isLoading = false;
  UserLocalDataSource userLocalDataSource = UserLocalDataSource();
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  /// to add tasks to firestore 
  Future<bool> addTask(String title, String description, String endDate) async {
    final docRef = firebase.collection("todo").doc();
    try {
      isLoading = true;
      notifyListeners();
      await docRef.set({
        "dateCreated": DateTime.now(),
        "description": description,
        "isDone": false,
        "taskId": docRef.id,
        "title": title,
        "endDate": endDate,
        "userId": await userLocalDataSource.getUserId()
      });
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
