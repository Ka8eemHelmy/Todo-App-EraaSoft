part of 'tasks_cubit.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}

class GetTasksLoadingState extends TasksState{}
class GetTasksSuccessState extends TasksState{}
class GetTasksErrorState extends TasksState{}
class EditTasksLoadingState extends TasksState{}
class EditTasksSuccessfulState extends TasksState{}
class EditTasksLErrorState extends TasksState{}

class DeleteTasksLoadingState extends TasksState{}
class DeleteTasksSuccessfulState extends TasksState{}
class DeleteTasksLErrorState extends TasksState{}