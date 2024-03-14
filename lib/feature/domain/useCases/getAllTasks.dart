
import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/useCases/UseCase.dart';
import '../entities/TaskEntity.dart';
import '../repositories/TaskRepository.dart';


class GetAllTasksUseCase implements UseCase<List<TaskEntity>, NoParams>{
  final TaskRepository repository;
  GetAllTasksUseCase(this.repository);
  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParams data) async{
    return await repository.getAllTasks();
  }
}