import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/model/TasksModel.dart';
import 'package:todo_app/view_model/constant.dart';
import 'package:todo_app/view_model/network/dioHelper.dart';
import 'package:todo_app/view_model/network/endPoints.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  static TasksCubit get(context) => BlocProvider.of<TasksCubit>(context);

  Tasks? tasksModel;


  Future getTasks() async {
    emit(GetTasksLoadingState());
    await DioHelper.getData(endPoint: tasks, token: token).then((value) {
      print(value.data);
      tasksModel = Tasks.fromJson(value.data);
      emit(GetTasksSuccessState());
    }).catchError((error){
      print('Get Tasks Error ${error.response.data}');
      emit(GetTasksErrorState());
    });
  }

  Future<void> editTask(
      {required int id,
      required String tittle,
      required String description,
      required String startDate,
      required String endDate,
      required String status}) async {
    emit(EditTasksLoadingState());
    await DioHelper.postData(
      endPoint: '$tasks/$id',
      data: {
        'title': tittle,
        'description': description,
        'start_date': startDate,
        'end_date': endDate,
        'status': status,
        '_method': 'PUT',
      },
      token: token,
    ).then((value) {
      print(value.data);
      emit(EditTasksSuccessfulState());
    }).catchError((onError) {
      if (onError is DioError) {
        print(onError.response?.data);
      }
      emit(EditTasksLErrorState());
    });
  }

  Future<void> deleteTask({required int id}) async {
    emit(DeleteTasksLoadingState());
    await DioHelper.deleteData(
      endPoint: '$tasks/$id',
      token: token,
    ).then((value) {
      print(value.data);
      emit(DeleteTasksSuccessfulState());
    }).catchError((onError) {
      print(onError.response.data);
      emit(DeleteTasksLErrorState());
    });
  }
}
