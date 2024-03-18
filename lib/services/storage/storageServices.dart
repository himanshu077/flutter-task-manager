import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../feature/data/models/TaskModel.dart';

class StorageService {
  static  Box<TaskModel>? _taskBox;

  Future? create() async {
    await _createBox();
    return;
  }

  Future<void> _createBox()async{
    if(_taskBox == null){
      WidgetsFlutterBinding.ensureInitialized();
      await Hive.initFlutter();
      Hive.registerAdapter<TaskModel>(TaskModelAdapter());
      _taskBox ??= await Hive.openBox<TaskModel>('task');
    }
    return;
  }

   Future<int?> addTask({required TaskModel data}) async {
    try {
      await _createBox();
        return await _taskBox!.add(data);
    } catch (e) {
      rethrow;
    }
  }

   Future<List<TaskModel>> getTaskList() async{
    try {
      await _createBox();
      final list = _taskBox!.values.toList();
      list.sort(
              (a, b) => a.timeStamp.compareTo(b.timeStamp),);
      return list;
    } catch (e) {
      rethrow;
    }
  }

   Future<void> updateTask({required TaskModel data}) async {
    try {
      await _createBox();
      final index = await _getKeyByCreatedAt(data.createdAt);
      if(index != null){
         await _taskBox!.putAt(index, data);
      }
      return;
    } catch (e) {
      rethrow;
    }
  }

   Future<void> removeTask({required TaskModel data}) async {
    try {
      await _createBox();
      final index = await _getKeyByCreatedAt(data.createdAt);
      if(index != null){
        await _taskBox!.deleteAt(index);
      }
      return;
    } catch (e) {
      rethrow;
    }
  }

   Future<int?> _getKeyByCreatedAt(int createdAt) async {
    for (var i = 0; i < _taskBox!.length; i++) {
      final task = _taskBox!.getAt(i);
      if (task != null && task.createdAt == createdAt) {
        return i;
      }
    }
    return null;
  }
}



