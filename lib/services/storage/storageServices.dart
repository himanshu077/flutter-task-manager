import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../feature/data/models/TaskModel.dart';

class StorageService {
  static late Box<TaskModel> _taskBox;

  static Future create() async {
    await Hive.initFlutter();
    Hive.registerAdapter<TaskModel>(TaskModelAdapter());
    _taskBox = await Hive.openBox<TaskModel>('task');
    return;
  }

  static Future<int> addTask({required TaskModel data}) async {
    try {
        return await _taskBox.add(data);
    } catch (e) {
      rethrow;
    }
  }

  static List<TaskModel> getTaskList() {
    try {
      final list = _taskBox.values.toList();
      list.sort(
              (a, b) => a.timeStamp.compareTo(b.timeStamp),);
      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateTask({required TaskModel data}) async {
    try {
      final index = await _getKeyByCreatedAt(data.createdAt);
      if(index != null){
         await _taskBox.putAt(index, data);
      }
      return;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> removeTask({required TaskModel data}) async {
    try {
      final index = await _getKeyByCreatedAt(data.createdAt);
      if(index != null){
        await _taskBox.deleteAt(index);
      }
      return;
    } catch (e) {
      rethrow;
    }
  }

  static Future<int?> _getKeyByCreatedAt(int createdAt) async {
    for (var i = 0; i < _taskBox.length; i++) {
      final task = _taskBox.getAt(i);
      if (task != null && task.createdAt == createdAt) {
        return i;
      }
    }
    return null;
  }
}



