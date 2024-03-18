import '../../../services/storage/storageServices.dart';
import '../models/TaskModel.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getAllTasks();

  Future<TaskModel> createNewTask(TaskModel data);

  Future<void> updateTask(TaskModel data);

  Future<bool> removeTask(TaskModel data);
}

class TaskLocalDataSourceImpl extends TaskLocalDataSource {
  final  StorageService _storage;

  TaskLocalDataSourceImpl({required StorageService storage}) : _storage = storage;

  @override
  Future<TaskModel> createNewTask(TaskModel data) async {
    try {
      final key = await _storage.addTask(data: data);
      return data.copyWith(key: key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      return await _storage.getTaskList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTask(TaskModel data) async {
    try {
      return await _storage.updateTask(data: data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> removeTask(TaskModel data) async {
    try {
      await _storage.removeTask(data: data);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
