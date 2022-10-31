import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

const String USER_ID = "USER_ID";
const String LOGGED_IN = "LOGGED_IN";

class UserLocalDataSource {

  Future<void> saveUserId(String userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(USER_ID, userId);
  }

  /// to save user login 
  Future<void> saveUserLoggedIn(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(LOGGED_IN, value);
  }

  /// to get user login
  Future<bool> getUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getBool(LOGGED_IN)?? false;
  }
  
  Future<String> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(USER_ID) ?? "";
  }
}
