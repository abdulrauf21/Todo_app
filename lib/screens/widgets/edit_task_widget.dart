import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/task_provider.dart';
import '../../model/todo_model.dart';

showEditTaskBottomSheet(BuildContext context, TodoModel todoModel) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return EditTask(todoModel: todoModel);
      });
}

class EditTask extends StatefulWidget {
  final TodoModel todoModel;
  const EditTask({Key? key, required this.todoModel}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.todoModel.title ?? "";
    descriptionController.text = widget.todoModel.description ?? "";
    endDateController.text = widget.todoModel.endDate ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              controller: titleController,
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
              controller: descriptionController,
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
              controller: endDateController,
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
                    widget.todoModel.endDate = endDateController.text;
                    widget.todoModel.title = titleController.text;
                    widget.todoModel.description = descriptionController.text;
                    Provider.of<TaskProvider>(context, listen: false)
                        .updateTask(widget.todoModel);
                    Provider.of<TaskProvider>(context, listen: false).getTask();
                    Navigator.pop(context);
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
