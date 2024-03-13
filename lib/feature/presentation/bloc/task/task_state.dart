part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskHomeLoadingState extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskHomeSuccessState extends TaskState {
  @override
  List<Object> get props => [];
}
class TaskHomeFailureState extends TaskState {
  final String error;
  const TaskHomeFailureState({required this.error});

  @override
  List<Object> get props => [error];
}

//create new task states...
class CreateTaskLoadingState extends TaskState {
  @override
  List<Object> get props => [];
}

class CreateTaskSuccessState extends TaskState {
  @override
  List<Object> get props => [];
}

class CreateTaskFailureState extends TaskState {
  final String error;

  const CreateTaskFailureState({required this.error});

  @override
  List<Object> get props => [error];
}

class CreateTaskFormValidationState extends TaskState {
  final String title;
  final String date;
  final String time;

  const CreateTaskFormValidationState(
      {required this.title, required this.date, required this.time});

  @override
  List<Object> get props => [title, date, time];
}

//update task states...
class UpdateTaskLoadingState extends TaskState {
  @override
  List<Object> get props => [];
}

class UpdateTaskSuccessState extends TaskState {
  @override
  List<Object> get props => [];
}

class UpdateTaskFailureState extends TaskState {
  final String error;

  const UpdateTaskFailureState({required this.error});

  @override
  List<Object> get props => [error];
}

class UpdateTaskFormValidationState extends TaskState {
  final String title;
  final String date;
  final String time;

  const UpdateTaskFormValidationState(
      {required this.title, required this.date, required this.time});

  @override
  List<Object> get props => [title, date, time];
}
