import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edittask_screen.dart';
import 'home_screen.dart';
import 'package:todo_app/controller/task_provider.dart';
import 'package:todo_app/model/todo_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();
  DateTime? selectedEndDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
                            Navigator.pop(context);
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
                        controller: titleEditingController,
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
                        controller: descriptionEditingController,
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
                      InkWell(
                        onTap: () async {
                          final datetime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2025),
                          );
                          if (datetime != null) {
                            setState(() {
                              selectedEndDate = datetime;
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          child: selectedEndDate == null
                              ? Text("Please tap to select end date")
                              : Text(
                                  "${selectedEndDate!.year.toString()}/${selectedEndDate!.month.toString()}/${selectedEndDate!.day.toString()}"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleEditingController.text.isNotEmpty &&
                        descriptionEditingController.text.isNotEmpty &&
                        selectedEndDate != null) {
                      TodoModel todoModel = TodoModel(
                        title: titleEditingController.text,
                        description: descriptionEditingController.text,
                        endDate: selectedEndDate,
                        isDone: false,
                      );
                      Provider.of<TaskProvider>(context, listen: false)
                          .addTask(todoModel)
                          .then(
                        (value) {
                          if (value == true) {
                            final snackBar = SnackBar(
                                content: Text("Task added successfully"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            titleEditingController.clear();
                            descriptionEditingController.clear();
                            selectedEndDate = null;
                            Provider.of<TaskProvider>(context, listen: false)
                                .getTask();
                            Navigator.pop(context);
                          } else {
                            final snackBar = SnackBar(content: Text("Failed"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                      );
                    } else {
                      final snackBar =
                          SnackBar(content: Text("Please fill the form"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
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
                )
              ],
            ),
          ),
          Provider.of<TaskProvider>(context).isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
