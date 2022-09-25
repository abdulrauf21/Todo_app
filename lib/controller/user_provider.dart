import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:todo_app/model/user_model.dart';

class UserProvider extends ChangeNotifier {
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
