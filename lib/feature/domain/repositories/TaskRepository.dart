import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../entities/TaskEntity.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getAllTasks();

  Future<Either<Failure, TaskEntity>> createNewTask({required TaskEntity data});

  Future<Either<Failure, TaskEntity>> updateTask({required TaskEntity data});

  Future<Either<Failure, bool>> removeTask({required TaskEntity data});
}
