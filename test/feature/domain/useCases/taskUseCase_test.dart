import 'package:dartz/dartz.dart';
import 'package:flutter_task_manager/core/useCases/UseCase.dart';
import 'package:flutter_task_manager/feature/domain/entities/TaskEntity.dart';
import 'package:flutter_task_manager/feature/domain/useCases/createNewTask.dart';
import 'package:flutter_task_manager/feature/domain/useCases/getAllTasks.dart';
import 'package:flutter_task_manager/feature/domain/useCases/removeTaskUseCase.dart';
import 'package:flutter_task_manager/feature/domain/useCases/updateTask.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


import '../../../helpers/test_helper.mocks.dart';

void main(){
  late GetAllTasksUseCase getTaskUseCase;
  late CreateNewTaskUseCase createNewTaskUseCase;
  late UpdateTaskUseCase updateTaskUseCase;
  late RemoveTaskUseCase removeTaskUseCase;
  late MockTaskRepository repository;

  setUpAll(() {
    repository = MockTaskRepository();
    getTaskUseCase = GetAllTasksUseCase(repository);
    createNewTaskUseCase = CreateNewTaskUseCase(repository: repository);
    updateTaskUseCase = UpdateTaskUseCase(repository: repository);
    removeTaskUseCase = RemoveTaskUseCase(repository: repository);
  });

  const List<TaskEntity> list = [
    TaskEntity(title: 'title', timeStamp: 1, createdAt: 1),
    TaskEntity(title: 'title', timeStamp: 1, createdAt: 1),
  ];

  const TaskEntity task = TaskEntity(title: 'title', timeStamp: 1, createdAt: 1);

  test('should get tasks list', () async {
    // arrange
    when(repository.getAllTasks()).thenAnswer((realInvocation) async => const Right(list));

    // act
    final result = await getTaskUseCase.call(NoParams());

    // assert
    expect(result, const Right(list));
  });

  test('should create new Task', () async {
    // arrange
    when(repository.createNewTask(data: task)).thenAnswer((realInvocation) async => const Right(task));

    // act
    final result = await createNewTaskUseCase.call(task);

    // assert
    expect(result, const Right(task));
  });

  test('should update Task', () async {
    // arrange
    when(repository.updateTask(data: task)).thenAnswer((realInvocation) async => const Right(task));

    // act
    final result = await updateTaskUseCase.call(task);

    // assert
    expect(result, const Right(task));
  });

  test('should remove Task', () async {
    // arrange
    when(repository.removeTask(data: task)).thenAnswer((realInvocation) async => const Right(true));

    // act
    final result = await removeTaskUseCase.call(task);

    // assert
    expect(result, const Right(true));
  });
}