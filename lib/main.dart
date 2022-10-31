import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/controller/auth_provider.dart';
import 'package:todo_app/controller/task_provider.dart';
import 'package:todo_app/controller/user_provider.dart';
import 'package:todo_app/local_data_source/user_local_data_source.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Navigation()
      ),
    );
  }
}

class Navigation extends StatelessWidget {
  Navigation({Key? key}) : super(key: key);
  final UserLocalDataSource userLocalDataSource = UserLocalDataSource();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userLocalDataSource.getUserLoggedIn(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          final result = snapshot.data as bool;
          if (result == true) {
            return HomeScreen();
          } else {
            return SplashScreen();
          }
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
