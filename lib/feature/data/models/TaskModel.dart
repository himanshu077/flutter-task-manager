import '../../domain/entities/TaskEntity.dart';

// TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));
//
// String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel extends TaskEntity {
  const TaskModel(
      {required String title, required String date, required String time})
      : super(title: title, date: date, time: time);

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json["title"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date": date,
        "time": time,
      };
}
