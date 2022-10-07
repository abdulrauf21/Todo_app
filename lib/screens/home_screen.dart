import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/task_provider.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/screens/widgets/edit_task_widget.dart';

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
                        "${Provider.of<TaskProvider>(context, listen: false).tasks?.length} task's",
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
                  child: Provider.of<TaskProvider>(context, listen: false)
                              .tasks ==
                          null
                      ? SizedBox()
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          shrinkWrap: true,
                          itemCount:
                              Provider.of<TaskProvider>(context, listen: false)
                                      .tasks
                                      ?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            TodoModel td = Provider.of<TaskProvider>(context,
                                    listen: false)
                                .tasks![index];
                            return InkWell(
                              onTap: () {
                                showEditTaskBottomSheet(context, td);
                              },
                              child: Container(
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
                                      value: td.isDone,
                                      onChanged: (value) {
                                        // setState(() {
                                        //   value = _value;
                                        // });
                                        td.isDone = value;
                                        Provider.of<TaskProvider>(context,
                                                listen: false)
                                            .updateTask(td);
                                        Provider.of<TaskProvider>(context,
                                                listen: false)
                                            .getTask();
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

