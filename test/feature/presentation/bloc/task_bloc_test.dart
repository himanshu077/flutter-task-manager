
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_task_manager/core/useCases/UseCase.dart';
import 'package:flutter_task_manager/core/utils/DateTimeUtils.dart';
import 'package:flutter_task_manager/feature/domain/entities/TaskEntity.dart';
import 'package:flutter_task_manager/feature/presentation/bloc/task/task_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main(){
  late MockGetAllTasksUseCase getAllTasksUseCase;
  late MockCreateNewTaskUseCase createNewTaskUseCase;
  late MockUpdateTaskUseCase updateTaskUseCase;
  late MockRemoveTaskUseCase removeTaskUseCase;
  late TaskBloc bloc;
  late MockStorageService storage;

  final stamp = DateTime.now().timeStamp;

  final  task = TaskEntity(title: 'title', timeStamp: stamp, createdAt: stamp);
  final  newTask = TaskEntity(title: 'title', timeStamp: stamp, createdAt: stamp, date: task.getDate, time: task.getTime);
  final  emptyTask = TaskEntity(title: '', timeStamp: stamp, createdAt: stamp);

  final  List<TaskEntity> list = [
    task,
    task,
    task
  ];

  setUpAll(() async{
    storage =  MockStorageService();
    when(storage.create()).thenAnswer((_) async => null);
    await storage.create();
    getAllTasksUseCase = MockGetAllTasksUseCase();
    createNewTaskUseCase = MockCreateNewTaskUseCase();
    updateTaskUseCase = MockUpdateTaskUseCase();
    removeTaskUseCase = MockRemoveTaskUseCase();
    bloc = TaskBloc();
  });

  test('initial state should be empty', (){
    expect(bloc.state, TaskInitial());
  });





  blocTest<TaskBloc,TaskState>('Should load all tasks', build: () {
    when(getAllTasksUseCase.call(NoParams())).thenAnswer((realInvocation) async => Right(list));
    return bloc;
  },

    act: (bloc) => bloc.add(FetchTasksEvent()),

    wait: const Duration(seconds: 0),

    expect: () => [
      TaskHomeLoadingState(),
      TaskHomeSuccessState(),
    ],
  );


  blocTest<TaskBloc,TaskState>('create Task when form is Empty', build: () {
    when(createNewTaskUseCase.call(emptyTask)).thenAnswer((realInvocation) async => Right(task));
    return bloc;
  },

    act: (bloc) => bloc.add(CreateTaskEvent(data: emptyTask)),

    wait: const Duration(seconds: 0),

    expect: () => [
      CreateTaskLoadingState(),
      const CreateTaskFormValidationState(title: 'Please enter task title', date: 'Please select date', time: 'Please select time'),
    ],
  );


  blocTest<TaskBloc,TaskState>('create Task with form detail', build: () {
    when(createNewTaskUseCase.call(newTask)).thenAnswer((realInvocation) async => Right(task));
    return bloc;
  },

    act: (bloc) => bloc.add(CreateTaskEvent(data: newTask)),

    wait: const Duration(seconds: 0),

    expect: () => [
      CreateTaskLoadingState(),
      CreateTaskSuccessState()
    ],
  );


  blocTest<TaskBloc,TaskState>('update Task with form empty', build: () {
    when(updateTaskUseCase.call(emptyTask)).thenAnswer((realInvocation) async => Right(task));
    return bloc;
  },

    act: (bloc) => bloc.add(UpdateTaskEvent(data: emptyTask)),

    wait: const Duration(seconds: 0),

    expect: () => [
      UpdateTaskLoadingState(),
      const UpdateTaskFormValidationState(title: 'Please enter task title', date: 'Please select date', time: 'Please select time')
    ],
  );


  blocTest<TaskBloc,TaskState>('update Task with form detail', build: () {
    when(updateTaskUseCase.call(newTask)).thenAnswer((realInvocation) async => Right(task));
    return bloc;
  },

    act: (bloc) => bloc.add(UpdateTaskEvent(data: newTask)),

    wait: const Duration(seconds: 0),

    expect: () => [
      UpdateTaskLoadingState(),
      UpdateTaskSuccessState()
    ],
  );


  blocTest<TaskBloc,TaskState>('remove task', build: () {
    when(removeTaskUseCase.call(newTask)).thenAnswer((realInvocation) async => const Right(true));
    return bloc;
  },

    act: (bloc) => bloc.add(RemoveTaskEvent(data: newTask, index: 1)),

    wait: const Duration(seconds: 0),

    expect: () => [
      TaskHomeLoadingState(),
      TaskHomeSuccessState()
    ],
  );


}