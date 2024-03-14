import 'package:equatable/equatable.dart';
import '../../../core/utils/DateTimeUtils.dart';

import '../../data/models/TaskModel.dart';

class TaskEntity extends Equatable {
  final String title;
  final int createdAt;
  final int timeStamp;
  final String? date;
  final String? time;

  const TaskEntity({
    required this.title,
    required this.timeStamp,
    required this.createdAt,
    this.date,
    this.time,
  });

  @override
  List<Object?> get props => [title, timeStamp, createdAt,date,time];

  TaskModel get model => TaskModel(
      timeStamp: timeStamp, createdAt: createdAt, title: title);

  bool get isValidTitle => title.trim().isNotEmpty;

  bool get isValidDate => date?.trim().isDate ?? false;

  bool get isValidTime => time?.trim().isTime ?? false;

  bool get checkIsValid => isValidTitle && isValidDate && isValidTime;

  String get getDate => date ?? timeStamp.dd_MMM_yyyy;

  String get getTime => time ?? timeStamp.hhmma;

  TaskEntity copyWith({int? key}) {
    return TaskEntity(
      title: title,
      timeStamp: timeStamp,
      createdAt: createdAt,
    );
  }

  TaskEntity copyCreateNew() {
    final pp = '$date $time';
    print(pp);
    final int stamp = '$date $time'.timeStamp_from_dd_MMM_yyyy_hhmma;
    return TaskEntity(
      title: title,
      timeStamp: stamp,
      createdAt: DateTime.now().timeStamp,
    );
  }

  TaskEntity copyUpdateTask(
      {required String date, required String time, required String title}) {
    final int stamp = date.isNotEmpty && time.isNotEmpty
        ? '$date $time'.timeStamp_from_dd_MMM_yyyy_hhmma
        : -1;
    return TaskEntity(
        title: title,
        timeStamp: stamp,
        createdAt: createdAt,
        date: date,
        time: time);
  }
}
