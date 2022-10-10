import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/local_data_source/user_local_data_source.dart';

class TaskProvider extends ChangeNotifier {
  bool isLoading = false;
  List<TodoModel>? tasks;
  UserLocalDataSource userLocalDataSource = UserLocalDataSource();
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

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
          .orderBy("dateCreated", descending: true)
          .get();
      List<TodoModel> todos =
          List.from(data.docs.map((e) => TodoModel.fromJson(e.data())));
      tasks = todos;
      isLoading = false;

      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw e;
    }
  }

  Future<void> updateTask(TodoModel todoModel) async {
    try {
      await firebase
          .collection("todo")
          .doc(todoModel.taskId)
          .update(todoModel.toMap());
    } catch (e) {
      throw e;
    }
  }
}
