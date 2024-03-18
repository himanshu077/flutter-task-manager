import 'package:dartz/dartz.dart';
import 'package:flutter_task_manager/services/storage/storageServices.dart';

import '../../../core/errors/failure.dart';
import '../../domain/entities/TaskEntity.dart';
import '../../domain/repositories/TaskRepository.dart';
import '../dataSources/TaskLocalDataSource.dart';

typedef Future<TaskEntity> _TaskEntityFun();
typedef Future<List<TaskEntity>> _TaskEntityListFun();

class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDataSource _localSource = TaskLocalDataSourceImpl(storage: StorageService());

  @override
  Future<Either<Failure, TaskEntity>> createNewTask(
      {required TaskEntity data}) async {
    return await _getTaskItem(() {
      return _localSource.createNewTask(data.model);
    });
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
    return await _getTaskList(() => _localSource.getAllTasks());
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTask(
      {required TaskEntity data}) async {
    return await _getTaskItem(() async {
      await _localSource.updateTask(data.model);
      return data;
    });
  }

  @override
  Future<Either<Failure, bool>> removeTask({required TaskEntity data}) async {
    try{
      final result = await _localSource.removeTask(data.model);
      return Right(result);
    }catch(e){
      return Left(ErrorFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, TaskEntity>> _getTaskItem(_TaskEntityFun fun) async {
    try{
      final result = await fun();
      return Right(result);
    }catch(e){
      return Left(ErrorFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<TaskEntity>>> _getTaskList(
      _TaskEntityListFun fun) async {
    try{
      final result = await fun();
      return Right(result);
    }catch(e){
      return Left(ErrorFailure(error: e.toString()));
    }
  }
}
