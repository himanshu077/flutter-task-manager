part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class FetchTasksEvent extends TaskEvent{
  @override
  List<Object?> get props => [];
}

class CreateTaskEvent extends TaskEvent{
  final TaskEntity data;

  const CreateTaskEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class UpdateTaskEvent extends TaskEvent{
  final TaskEntity data;

  const UpdateTaskEvent( {required this.data,});

  @override
  List<Object?> get props => [data];
}

class RemoveTaskEvent extends TaskEvent{
  final TaskEntity data;
  final int index;

  const RemoveTaskEvent( {required this.data,required this.index,});

  @override
  List<Object?> get props => [data, index];
}
