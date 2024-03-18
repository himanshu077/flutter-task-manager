import 'package:flutter_task_manager/core/utils/DateTimeUtils.dart';
import 'package:flutter_task_manager/feature/data/models/TaskModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockStorageService storage;

  late MockTaskLocalDataSourceImpl localDataSourceImpl;

  final stamp = DateTime.now().timeStamp;
  final TaskModel model = TaskModel(title: 'title', timeStamp: stamp, createdAt: stamp);

  final List<TaskModel> list = [
    model,
    model,
    model
  ];


  setUpAll(() async{
    storage = MockStorageService();
    when(storage.create()).thenAnswer((_) async => null);
    await storage.create();
    localDataSourceImpl = MockTaskLocalDataSourceImpl();
  });


  group('local data test', () {

    test('get all Tasks', () async{
      // arrange
      when(localDataSourceImpl.getAllTasks()).thenAnswer((realInvocation) async => list);

      // act
      final result = await localDataSourceImpl.getAllTasks();

      // assert
      expect(result, list);
    });

    test('create new Tasks', () async{
      // arrange
      when(localDataSourceImpl.createNewTask(model))
          .thenAnswer((realInvocation) async => model); // Return model directly

      // act
      final result = await localDataSourceImpl.createNewTask(model);

      // assert
      expect(result, model);
    });


    test('update Tasks', () async{
      // arrange
      when(localDataSourceImpl.updateTask(model)).thenAnswer((realInvocation) async {});

      // act
      final result = await localDataSourceImpl.updateTask(model);

      // assert
      verify(localDataSourceImpl.updateTask(model)).called(1);
    });


    test('remove Tasks', () async{
      // arrange
      when(localDataSourceImpl.removeTask(model)).thenAnswer((realInvocation) async => true);

      // act
      final result = await localDataSourceImpl.removeTask(model);

      // assert
      expect(result, true);
    });
  });
}
