part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class FetchTasksEvent extends TaskEvent{
  @override
  List<Object?> get props => [];
}

class CreateTaskEvent extends TaskEvent{
  final String title;
  final String date;
  final String time;

  const CreateTaskEvent({required this.title, required this.date, required this.time});

  @override
  List<Object?> get props => [title,date, time];
}

class UpdateTaskEvent extends TaskEvent{
  final String title;
  final String date;
  final String time;

  const UpdateTaskEvent({required this.title, required this.date, required this.time});

  @override
  List<Object?> get props => [title,date, time];
}

class RemoveTaskEvent extends TaskEvent{
  final String id;

  const RemoveTaskEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
