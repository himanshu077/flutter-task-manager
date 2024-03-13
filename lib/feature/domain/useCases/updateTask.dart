import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/useCases/UseCase.dart';
import '../entities/TaskEntity.dart';
import '../repositories/TaskRepository.dart';


class UpdateTaskUseCase extends UseCase<TaskEntity,TaskEntity>{
  final TaskRepository repository;

  UpdateTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, TaskEntity>> call(TaskEntity params) async{
    return await repository.updateTask(data: params);
  }
}