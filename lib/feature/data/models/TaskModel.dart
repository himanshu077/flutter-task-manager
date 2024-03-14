import 'package:hive/hive.dart';

import '../../domain/entities/TaskEntity.dart';

part 'TaskModel.g.dart';

@HiveType(typeId: 0)
class TaskModel extends TaskEntity {

  @HiveField(0)
  final String title;

  @HiveField(1)
  final int timeStamp;

  @HiveField(2)
  final int createdAt;

   const TaskModel({required this.title, required this.timeStamp, required this.createdAt})
      : super(title: title, createdAt: createdAt, timeStamp: timeStamp);

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json["title"],
        timeStamp: json["timeStamp"],
    createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "timeStamp": timeStamp,
        "createdAt": createdAt,
      };


  TaskModel copyWith({int? key}) {
    return TaskModel(
      title: title,
      timeStamp: timeStamp,
      createdAt: createdAt,
    );
  }
}
