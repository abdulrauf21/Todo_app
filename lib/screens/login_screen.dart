import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/user_provider.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: "Enter your email", label: Text("Email")),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: "Enter your password", label: Text("Password")),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      UserModel userModel = UserModel(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      Provider.of<UserProvider>(context, listen: false)
                          .login(userModel)
                          .then((value) {
                        if (value == true) {
                          _emailController.clear();
                          _passwordController.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        } else {
                          final snackBar = SnackBar(
                              content:
                                  Text("Email and password did not match !!"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                    } else {
                      final snackBar = SnackBar(
                          content: Text(
                              "Email and password is Empty. Please fill!!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text("Login"),
                )
              ],
            ),
            Provider.of<UserProvider>(context).isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
