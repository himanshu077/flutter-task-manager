
import 'package:flutter_task_manager/core/utils/DateTimeUtils.dart';
import 'package:flutter_task_manager/feature/data/models/TaskModel.dart';
import 'package:flutter_task_manager/feature/domain/entities/TaskEntity.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  const String title = 'title';
  int timeStamp = DateTime.now().timeStamp;
  final model = TaskModel(title: title, timeStamp: timeStamp, createdAt: timeStamp);

  final Map<String,dynamic> json = {
    "title": title,
  "timeStamp": timeStamp,
  "createdAt": timeStamp,
};

  test('should be a sub class of TaskEntity', () {

    // assert
    expect(model, isA<TaskEntity>());

  });


  test('should return valid model from Map', () {

    // arrange

    // act
    final result = TaskModel.fromJson(json);

    // assert
    expect(result, equals(model));

  });

  test('should return Map from containing proper data', () {

    // arrange

    // act
    final result = model.toJson();

    // assert
    expect(result, equals(json));

  });
}