import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:todo_app/local_data_source/user_local_data_source.dart';
import 'package:todo_app/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserLocalDataSource userLocalDataSource = UserLocalDataSource();
  bool isLoading = false;
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  Future<bool> login(UserModel userModel) async {
    isLoading = true;
    notifyListeners();
    final snapshot = await firebase
        .collection("user")
        .where("email", isEqualTo: userModel.email)
        .where("password", isEqualTo: userModel.password)
        .get();
    if (snapshot.docs.isNotEmpty) {
      isLoading = false;
      notifyListeners();
      await userLocalDataSource.saveUserId(snapshot.docs[0].id);
      return true;
      // user found
      // login
    } else {
      isLoading = false;
      notifyListeners();
      return false;
      // user not found
      // password or email incorrect
    }
  }
}
