import '../../../services/storage/storageServices.dart';
import '../models/TaskModel.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getAllTasks();

  Future<TaskModel> createNewTask(TaskModel data);

  Future<void> updateTask(TaskModel data);

  Future<bool> removeTask(TaskModel data);
}

class TaskLocalDataSourceImpl extends TaskLocalDataSource {

  @override
  Future<TaskModel> createNewTask(TaskModel data) async {
    try {
      final key = await StorageService.addTask(data: data);
      return data.copyWith(key: key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      return StorageService.getTaskList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTask(TaskModel data) async {
    try {
      return await StorageService.updateTask(data: data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> removeTask(TaskModel data) async {
    try {
      await StorageService.removeTask(data: data);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
