import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/task_provider.dart';
import 'package:todo_app/model/todo_model.dart';

import 'addtask_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _value = false;
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).getTask();
  }

  @override
  Widget build(BuildContext context) {
    List noteslist = [
      {"date": "9 Sep 2022", "description": "Example tod..."},
      {"date": "8 Nov 2022", "description": "Example tod..."},
      {"date": "6 Oct 2022", "description": "Example tod..."},
      {"date": "19 Sep 2022", "description": "Example tod..."},
      {"date": "5 May 2022", "description": "Example tod..."},
      {"date": "8 Feb 2022", "description": "Example tod..."},
      {"date": "23 Jan 2022", "description": "Example tod..."},
      {"date": "6 Jun 2022", "description": "Example tod..."},
      {"date": "21 Oct 2022", "description": "Example tod..."},
    ];
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 62, 20, 5),
                        //  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15),),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(150, 30, 150, 0),
                      child: Image.asset("assets/Logo.png"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "8 Todos",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "View all",
                        style: TextStyle(
                          color: Color(0xff1AB8DB),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {
                          setState(() {
                            value = _value;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      SizedBox(
                        width: 28,
                      ),
                      Text(
                        "Date",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 64,
                      ),
                      Text(
                        "Task",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 320,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10);
                    },
                    shrinkWrap: true,
                    itemCount:  Provider.of<TaskProvider>(context, listen: false).tasks.length,
                    itemBuilder: (context, index) {
                      TodoModel td = Provider.of<TaskProvider>(context, listen: false).tasks[index];
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        padding: EdgeInsets.only(
                          left: 19,
                          right: 16,
                          top: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: false,
                              onChanged: (value) {
                                setState(() {
                                  value = _value;
                                });
                              },
                              activeColor: Colors.green,
                            ),
                            Text(
                              td.endDate ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                color: Color(0xff222222),
                              ),
                            ),
                            SizedBox(
                              width: 9,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  td.title ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 15,
                      bottom: 15,
                    ),
                    primary: Colors.white,
                    shape: StadiumBorder(),
                    side: BorderSide(
                      color: Color(0xff1AB8DB),
                      width: 2,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Load more...",
                    style: TextStyle(
                      color: Color(0xff1AB8DB),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Container(
                      height: 65,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffEEEEEE),
                      ),
                    ),
                    Center(
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddTaskScreen(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Provider.of<TaskProvider>(context).isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}