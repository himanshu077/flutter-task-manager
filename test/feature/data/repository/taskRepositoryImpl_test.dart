import 'package:dartz/dartz.dart';
import 'package:flutter_task_manager/core/utils/DateTimeUtils.dart';
import 'package:flutter_task_manager/feature/domain/entities/TaskEntity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main(){

  late MockTaskRepositoryImpl repositoryImpl;

  final stamp = DateTime.now().timeStamp;
  final entity = TaskEntity(title: 'title', timeStamp: stamp, createdAt: stamp);

  final list = [entity,entity,entity];

  setUp(() {
    repositoryImpl = MockTaskRepositoryImpl();
  });


  test('create task', () async{

    // arrange
    when(repositoryImpl.createNewTask(data: entity)).thenAnswer((realInvocation) async=>  Right(entity));

    // act
    final result = await repositoryImpl.createNewTask(data: entity);

    // assert
    expect(result, Right(entity));

  });


  test('update task', () async{

    // arrange
    when(repositoryImpl.updateTask(data: entity)).thenAnswer((realInvocation) async=>  Right(entity));

    // act
    final result = await repositoryImpl.updateTask(data: entity);

    // assert
    expect(result, Right(entity));

  });


  test('get all tasks', () async{

    // arrange
    when(repositoryImpl.getAllTasks()).thenAnswer((realInvocation) async=>  Right(list));

    // act
    final result = await repositoryImpl.getAllTasks();

    // assert
    expect(result, Right(list));

  });


  test('remove task', () async{

    // arrange
    when(repositoryImpl.removeTask(data: entity)).thenAnswer((realInvocation) async=>  const Right(true));

    // act
    final result = await repositoryImpl.removeTask(data: entity);

    // assert
    expect(result, const Right(true));

  });
}