import 'package:shared_preferences/shared_preferences.dart';

const String USER_ID = "USER_ID";

class UserLocalDataSource {

  Future<void> saveUserId(String userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(USER_ID, userId);
  }

  Future<String> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(USER_ID) ?? "";
  }
}
