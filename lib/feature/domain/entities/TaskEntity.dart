import 'package:equatable/equatable.dart';

import '../../data/models/TaskModel.dart';

class TaskEntity extends Equatable {
  final String title;
  final String date;
  final String time;

  const TaskEntity({
    required this.title,
    required this.date,
    required this.time,
  });

  @override
  List<Object?> get props => [title, date, time];

  TaskModel get model => TaskModel(time: time, date: date, title: title);

  bool get isValidTitle => title.trim().isNotEmpty;

  bool get isValidDate => date.trim().isNotEmpty;

  bool get isValidTime => time.trim().isNotEmpty;

  bool get checkIsValid => isValidTitle && isValidDate && isValidTime;
}
