import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

// General failures
class ServerFailure extends Failure {
  final String error;

  const ServerFailure({required this.error});
  @override
  List<Object?> get props => [error];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ErrorFailure extends Failure {
  final String error;

  const ErrorFailure({required this.error});

  @override
  List<Object?> get props => [error];
}