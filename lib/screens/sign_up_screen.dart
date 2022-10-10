import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                    hintText: "Confirm your password",
                    label: Text("Confirm password")),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty &&
                      _confirmPasswordController.text.isNotEmpty) {
                    if (_passwordController.text ==
                        _confirmPasswordController.text) {
                      Provider.of<AuthProvider>(context, listen:  false)
                          .signUpWithEmailAndPassword(
                              _emailController.text, _passwordController.text, context);
                    } else {
                      final snackbar =
                          SnackBar(content: Text("Password didnot match"));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  } else {
                    final snackbar =
                        SnackBar(content: Text("All fields are required"));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                },
                child: Text("Sign up"),
              )
            ],
          ),
          Provider.of<AuthProvider>(context).isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
