import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/user_provider.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff2DC369),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 140,
                ),
                const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 47,
                  width: 115,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      label: Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Enter your email or username",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      label: Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Enter your password",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                ),
              ],
            ),
          ),
          Provider.of<UserProvider>(context).isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
