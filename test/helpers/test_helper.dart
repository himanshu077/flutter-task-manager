import 'package:flutter_task_manager/feature/data/dataSources/TaskLocalDataSource.dart';
import 'package:flutter_task_manager/feature/data/repositories/TaskRepositoryImpl.dart';
import 'package:flutter_task_manager/feature/domain/repositories/TaskRepository.dart';
import 'package:flutter_task_manager/feature/domain/useCases/createNewTask.dart';
import 'package:flutter_task_manager/feature/domain/useCases/getAllTasks.dart';
import 'package:flutter_task_manager/feature/domain/useCases/removeTaskUseCase.dart';
import 'package:flutter_task_manager/feature/domain/useCases/updateTask.dart';
import 'package:flutter_task_manager/feature/presentation/bloc/task/task_bloc.dart';
import 'package:flutter_task_manager/services/storage/storageServices.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([TaskRepository,
  GetAllTasksUseCase,
  CreateNewTaskUseCase,
  UpdateTaskUseCase,
  RemoveTaskUseCase,
  StorageService,
  TaskLocalDataSourceImpl,
  TaskRepositoryImpl,
  TaskBloc,
  Box])
void main() {}
