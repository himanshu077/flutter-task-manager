import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/useCases/UseCase.dart';
import '../entities/TaskEntity.dart';
import '../repositories/TaskRepository.dart';


class CreateNewTaskUseCase extends UseCase<TaskEntity,TaskEntity>{
  final TaskRepository repository;

  CreateNewTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, TaskEntity>> call(params) async{
    return await repository.createNewTask(data: params);
  }
}