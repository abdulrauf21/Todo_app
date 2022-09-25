import 'package:flutter/material.dart';
import 'package:todo_app/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffE50000),
                  Color(0xff1593AF),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              height: 570,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 58, 58, 58),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 56,
                  ),
                  Image.asset("assets/Logo.png"),
                  SizedBox(
                    height: 37,
                  ),
                  Image.asset("assets/Make successful your day.png"),
                  SizedBox(
                    height: 44,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 33),
                    child: Text(
                      "Make small somethings to get big gift in your life",
                      style: TextStyle(
                        color: Color(0xffC1CC41),
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 54,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder:(context)=>HomeScreen(),),);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(150, 45),
                      primary: Color(0xff1AB8DB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Start",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
