import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../domain/entities/TaskEntity.dart';
import '../../domain/repositories/TaskRepository.dart';
import '../dataSources/TaskLocalDataSource.dart';

typedef Future<TaskEntity> _TaskEntityFun();
typedef Future<List<TaskEntity>> _TaskEntityListFun();

class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDataSource _localSource = TaskLocalDataSourceImpl();

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
    return await _getTaskItem(() {
      return _localSource.updateTask(data.model);
    });
  }

  @override
  Future<Either<Failure, bool>> removeTask({required TaskEntity data}) async {
    final result = await _localSource.removeTask(data.model);
    return Right(result);
  }

  Future<Either<Failure, TaskEntity>> _getTaskItem(_TaskEntityFun fun) async {
    final result = await fun();
    return Right(result);
  }

  Future<Either<Failure, List<TaskEntity>>> _getTaskList(
      _TaskEntityListFun fun) async {
    final result = await fun();
    return Right(result);
    // if (await networkInfo.isConnected) {
    //   try {
    //     final remoteTrivia = await getConcreteOrRandom();
    //     localDataSource.cacheNumberTrivia(remoteTrivia);
    //     return Right(remoteTrivia);
    //   } on ServerException {
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   try {
    //     final localTrivia = await localDataSource.getLastNumberTrivia();
    //     return Right(localTrivia);
    //   } on CacheException {
    //     return Left(CacheFailure());
    //   }
    // }
  }
}
