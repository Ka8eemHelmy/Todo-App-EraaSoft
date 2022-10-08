import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/view/components/Tasks/taskWidget.dart';
import 'package:todo_app/view_model/bloc/tasks/tasks_cubit.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({Key? key}) : super(key: key);

  var tittleController = TextEditingController();
  var descriptionController = TextEditingController();
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  var statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<TasksCubit>(context)..getTasks(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<TasksCubit, TasksState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = TasksCubit.get(context);
              return cubit.tasksModel == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemBuilder: (context, index) => TaskWidget(task: cubit.tasksModel?.response?.data?[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemCount: cubit.tasksModel?.response?.data?.length ?? 0,
                    );
            },
          ),
        ),
        floatingActionButton: CircleAvatar(
          radius: 30,
          child: IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Add Task',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: tittleController,
                            decoration: InputDecoration(
                              labelText: 'Tittle',
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              labelText: 'Description',
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: startDateController,
                            keyboardType: TextInputType.none,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100, 1, 1),
                              ).then((value) => endDateController.text =
                              value != null ? '${value.year}/${value.month ?? 0}/${value.day ?? 0}' : '');
                            },
                            decoration: InputDecoration(
                              labelText: 'Start Date',
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: endDateController,
                            keyboardType: TextInputType.none,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100, 1, 1),
                              ).then((value) => endDateController.text =
                                  value != null ? '${value.year}/${value.month ?? 0}/${value.day ?? 0}' : '');
                            },
                            decoration: InputDecoration(
                              labelText: 'End Date',
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            icon: Icon(
              Icons.add,
            ),
            iconSize: 30,
          ),
        ),
      ),
    );
  }
}
