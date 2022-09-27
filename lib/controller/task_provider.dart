import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/local_data_source/user_local_data_source.dart';
import 'package:todo_app/model/todo_model.dart';

class TaskProvider extends ChangeNotifier {
  bool isLoading = false;
  List<TodoModel> tasks = [];
  UserLocalDataSource userLocalDataSource = UserLocalDataSource();
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  /// to add tasks to firestore
  Future<bool> addTask(TodoModel todoModel) async {
    final docRef = firebase.collection("todo").doc();
    todoModel.dateCreated = DateTime.now();
    todoModel.taskId = docRef.id;
    todoModel.userId = await userLocalDataSource.getUserId();

    try {
      isLoading = true;
      notifyListeners();
      await docRef.set(
        todoModel.toMap(),
        // "dateCreated": DateTime.now(),
        // "description": description,
        // "isDone": false,
        // "taskId": docRef.id,
        // "title": title,
        // "endDate": endDate,
        // "userId": await userLocalDataSource.getUserId()
      );
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getTask() async {
    final userId = await userLocalDataSource.getUserId();
    try {
      isLoading = true;
      notifyListeners();
      final data = await firebase
          .collection("todo")
          .where("userId", isEqualTo: userId)
          .get();
      data.docs.forEach((element) {
        TodoModel todo = TodoModel.fromJson(element.data());
        tasks.add(todo);
      });
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw e;
    }
  }
}
