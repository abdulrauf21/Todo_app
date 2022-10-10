import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/local_data_source/user_local_data_source.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserLocalDataSource userLocalDataSource = UserLocalDataSource();
  bool isLoading = false;

  // to create user or sign up user with email and password
  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uId = result.user!.uid;
      final _email = result.user!.email!;
      await saveUserInfoIntoDatabase(_email, uId);
      isLoading = false;
      notifyListeners();
      
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      if (e.code == 'weak-password') {
        final snackbar = SnackBar(content: Text("Your password is weak"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else if (e.code == 'email-already-in-use') {
        final snackbar = SnackBar(
            content: Text("The account already exists for that email."));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        print('The account already exists for that email.');
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw e;
    }
  }

  // to login the user using email and password
  Future<bool> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      isLoading = false;
      notifyListeners();
      await userLocalDataSource.saveUserId(result.user!.uid); 
      return true;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        final snackbar =
            SnackBar(content: Text("No user found for that email."));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        final snackbar =
            SnackBar(content: Text("Password you entered is wrong"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
      return false;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // to store siggend up user into firebase database in the collection [users]
  Future<void> saveUserInfoIntoDatabase(String email, String uId) async {
    await _firebaseFirestore.collection("users").add({
      "email": email,
      "userId": uId,
    });
  }
}
