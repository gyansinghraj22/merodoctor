import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.message);
}
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
class UnauthenticatedFailure extends Failure {
  const UnauthenticatedFailure(super.message);
}
class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure(super.message);
}
class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message);
}
class ConflictFailure extends Failure {
  const ConflictFailure(super.message);
}
class BadRequestFailure extends Failure {
  const BadRequestFailure(super.message);
}
class ServiceUnavailableFailure extends Failure {
  const ServiceUnavailableFailure(super.message);
}


// Auth failures
