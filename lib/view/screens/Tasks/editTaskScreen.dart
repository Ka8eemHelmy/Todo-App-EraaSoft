import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/TasksModel.dart';
import 'package:todo_app/view_model/bloc/tasks/tasks_cubit.dart';

class EditTaskScreen extends StatefulWidget {
  Data? task;

  EditTaskScreen({required this.task, Key? key}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  void initState() {
    titleController.text = widget.task!.title!;
    descriptionController.text = widget.task!.description!;
    super.initState();
  }

  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please, Enter your Title of Note';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please, Enter your Description of Note';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Description',
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            TasksCubit.get(context).editTask(
                              id: widget.task!.id!,
                              tittle: titleController.text,
                              description: descriptionController.text,
                              startDate: 'startDate',
                              endDate: 'endDate',
                              status: 'status',
                            );
                          }
                        },
                        child: Text('Edit'),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {

                          }
                        },
                        child: Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
