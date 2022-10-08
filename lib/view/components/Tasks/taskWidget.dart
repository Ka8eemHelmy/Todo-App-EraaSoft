import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/TasksModel.dart';

class TaskWidget extends StatelessWidget {
  Data? task;

  TaskWidget({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => EditTaskScreen(
        //               task: task,
        //             )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task?.title ?? '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              task?.description ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Icon(
                  Icons.timer_outlined,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat("hh:mm").format(DateTime.parse(task!.createdAt!)),
                ),
                Spacer(),
                Icon(
                  Icons.timelapse_rounded,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat("hh:mm").format(DateTime.parse(task!.endDate!)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
