import 'package:flutter/material.dart';

import 'edittask_screen.dart';
import 'home_screen.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ADD TASK",
                    style: TextStyle(
                      color: Color(0xff1AB8DB),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }),
                    child: Icon(
                      Icons.close,
                      color: Color(0xff1AB8DB),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Center(
            child: Image.asset("assets/Logo.png"),
          ),
          SizedBox(
            height: 44,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Title(
                    color: Colors.black,
                    child: Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Enter task title',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Title(
                    color: Colors.black,
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Enter task description',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Title(
                    color: Colors.black,
                    child: Text(
                      "Date end",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Click here to choose date',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Saved"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    color: Color.fromARGB(255, 20, 196, 235),
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      "okay",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(106, 40),
                          primary: Color(0xff1AB8DB),
                          shape: StadiumBorder(),
                        ),
                        child: Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                       ElevatedButton(
                        onPressed: () {
                           Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditTaskScreen(),
                          ),
                        );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(106, 40),
                          primary: Color(0xff1AB8DB),
                          shape: StadiumBorder(),
                        ),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                           Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(106, 40),
                          primary: Color.fromARGB(255, 243, 31, 31),
                          shape: StadiumBorder(),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
