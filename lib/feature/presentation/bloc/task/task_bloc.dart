import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/appExtension.dart';
import '../../../../core/useCases/UseCase.dart';
import '../../../data/repositories/TaskRepositoryImpl.dart';
import '../../../domain/entities/TaskEntity.dart';
import '../../../domain/repositories/TaskRepository.dart';
import '../../../domain/useCases/createNewTask.dart';
import '../../../domain/useCases/getAllTasks.dart';
import '../../../domain/useCases/removeTaskUseCase.dart';
import '../../../domain/useCases/updateTask.dart';

part 'task_event.dart';

part 'task_state.dart';

final TaskRepository repo = TaskRepositoryImpl();

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasksUseCase getAllTaskUseCase = GetAllTasksUseCase(repo);
  final CreateNewTaskUseCase createNewTaskUseCase =
      CreateNewTaskUseCase(repository: repo);
  final UpdateTaskUseCase updateTaskUseCase =
      UpdateTaskUseCase(repository: repo);
  final RemoveTaskUseCase removeTaskUseCase =
      RemoveTaskUseCase(repository: repo);

  List<TaskEntity> tasks = [];

  int updateTaskIndex = -1;

  TaskEntity get taskForUpdate => tasks[updateTaskIndex];

  TaskBloc() : super(TaskInitial()) {
    on<TaskEvent>((event, emit) {});
    on<FetchTasksEvent>(_onFetchTask);
    on<CreateTaskEvent>(_onCreateTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<RemoveTaskEvent>(_onRemoveTask);
  }

  FutureOr<void> _onCreateTask(
      CreateTaskEvent event, Emitter<TaskState> emit) async {
    emit(CreateTaskLoadingState());
    if (event.data.checkIsValid) {
      final task = event.data.copyCreateNew();
      final result = await createNewTaskUseCase.call(task);
      result.fold(
          (failure) => emit(CreateTaskFailureState(error: failure.value)),
          (data) {
            tasks.add(task);
            _sortTasks();
            emit(CreateTaskSuccessState());
          });
    } else {
      emit(CreateTaskFormValidationState(
          title: event.data.isValidTitle ? '' : 'Please enter task title',
          date: event.data.isValidDate ? '' : 'Please select date',
          time: event.data.isValidTime ? '' : 'Please select time'));
    }
  }

  TaskState getState(){
    return state;
  }

  FutureOr<void> _onUpdateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(UpdateTaskLoadingState());
    if (event.data.checkIsValid) {
      final task = event.data.copyWith(key: updateTaskIndex);
      final result = await updateTaskUseCase.call(task);
      result.fold(
          (failure) => emit(UpdateTaskFailureState(error: failure.value)),
          (data) {
            if(tasks.isNotEmpty && updateTaskIndex < tasks.length){
              tasks[updateTaskIndex] = task;
              _sortTasks();
            }
            emit(UpdateTaskSuccessState());
          });
    } else {
      emit(UpdateTaskFormValidationState(
          title: event.data.isValidTitle ? '' : 'Please enter task title',
          date: event.data.isValidDate ? '' : 'Please select date',
          time: event.data.isValidTime ? '' : 'Please select time'));
    }
  }

  FutureOr<void> _onRemoveTask(
      RemoveTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskHomeLoadingState());
    final result = await removeTaskUseCase.call(event.data);
    result.fold((failure) => emit(TaskHomeFailureState(error: failure.value)),
        (data) {
      if(tasks.isNotEmpty && event.index < tasks.length){
        tasks.removeAt(event.index);
      }
      emit(TaskHomeSuccessState());
    });
  }

  FutureOr<void> _onFetchTask(
      FetchTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskHomeLoadingState());
    final result = await getAllTaskUseCase.call(NoParams());
    result.fold((failure) => emit(TaskHomeFailureState(error: failure.value)),
        (data) {
      tasks.cast();
      tasks.addAll(data);
      emit(TaskHomeSuccessState());
    });
  }


  void _sortTasks(){
    tasks.sort(
          (a, b) => a.timeStamp.compareTo(b.timeStamp),);
  }
}
