import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List tasks = ['','','','','','','',];
  TaskBloc() : super(TaskInitial()) {
    on<TaskEvent>((event, emit) {});
    on<FetchTasksEvent>(_onFetchTask);
    on<CreateTaskEvent>(_onCreateTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<RemoveTaskEvent>(_onRemoveTask);
    }


  FutureOr<void> _onCreateTask(CreateTaskEvent event, Emitter<TaskState> emit) async{
    emit(CreateTaskLoadingState());
    if(event.title.isNotEmpty && event.date.isNotEmpty && event.time.isNotEmpty){
      await Future.delayed(const Duration(seconds: 3));
      emit(CreateTaskSuccessState());
    }else{
      emit(CreateTaskFormValidationState(
          title: event.title.isNotEmpty ? '': 'Please enter task title',
          date: event.date.isNotEmpty ? '' : 'Please select date',
          time: event.time.isNotEmpty ? '' : 'Please select time'
      ));
    }
  }

  FutureOr<void> _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async{
    emit(UpdateTaskLoadingState());
    if(event.title.isNotEmpty && event.date.isNotEmpty && event.time.isNotEmpty){
      await Future.delayed(const Duration(seconds: 3));
      emit(UpdateTaskSuccessState());
    }else{
      emit(UpdateTaskFormValidationState(
          title: event.title.isNotEmpty ? '': 'Please enter task title',
          date: event.date.isNotEmpty ? '' : 'Please select date',
          time: event.time.isNotEmpty ? '' : 'Please select time'
      ));
    }
  }

  FutureOr<void> _onRemoveTask(RemoveTaskEvent event, Emitter<TaskState> emit) async{
    emit(TaskHomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(TaskHomeSuccessState());
  }

  FutureOr<void> _onFetchTask(FetchTasksEvent event, Emitter<TaskState> emit) async{
    emit(TaskHomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(TaskHomeSuccessState());
  }
}
