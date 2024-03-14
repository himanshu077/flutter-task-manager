import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/useCases/UseCase.dart';
import '../entities/TaskEntity.dart';
import '../repositories/TaskRepository.dart';

class RemoveTaskUseCase implements UseCase<bool, TaskEntity> {
  final TaskRepository repository;

  const RemoveTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(TaskEntity params) async {
    return await repository.removeTask(data: params);
  }
}
