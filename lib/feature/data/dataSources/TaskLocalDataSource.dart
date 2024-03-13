import '../models/TaskModel.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getAllTasks();

  Future<TaskModel> createNewTask(TaskModel data);

  Future<TaskModel> updateTask(TaskModel data);

  Future<bool> removeTask(TaskModel data);
}

class TaskLocalDataSourceImpl extends TaskLocalDataSource {
  @override
  Future<TaskModel> createNewTask(TaskModel data) async {
    await Future.delayed(Duration(seconds: 3));
    return TaskModel(title: '', time: '', date: '');
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    await Future.delayed(Duration(seconds: 3));
    return [TaskModel(title: 'title', date: '12-03-2024', time: '8:30 AM')];
  }

  @override
  Future<TaskModel> updateTask(TaskModel data) async {
    await Future.delayed(Duration(seconds: 3));
    return TaskModel(title: '', time: '', date: '');
  }

  @override
  Future<bool> removeTask(TaskModel data) async {
    await Future.delayed(Duration(seconds: 3));
    return true;
  }
}
