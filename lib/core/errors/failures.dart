import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Represents an error originating from the server.
class ServerFailure extends Failure {
  const ServerFailure({String message = 'A server error occurred. Please try again later.'}) : super(message);
}

/// Represents an error when trying to read from or write to the device's cache.
class CacheFailure extends Failure {
  const CacheFailure({String message = 'Failed to access local data. Please try again.'}) : super(message);
}

/// Represents a network-related issue, such as no internet connection or a timeout.
class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'Please check your internet connection and try again.'}) : super(message);
}

/// Represents an error for invalid or malformed user input.
class InvalidInputFailure extends Failure {
  const InvalidInputFailure({String message = 'The provided input is invalid. Please check the information and try again.'}) : super(message);
}

/// Represents an error where the user is authenticated but does not have permission to access a resource.
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({String message = 'You do not have permission to perform this action.'}) : super(message);
}

/// Represents a resource that could not be found on the server.
class NotFoundFailure extends Failure {
  const NotFoundFailure({String message = 'The requested resource could not be found.'}) : super(message);
}

/// Represents a specific failure for when a user with the given credentials does not exist.
class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure({String message = 'User not found. Please check your email and try again.'}) : super(message);
}

/// Represents a specific failure for incorrect password entry during authentication.
class WrongPasswordFailure extends Failure {
  const WrongPasswordFailure({String message = 'Invalid password. Please try again.'}) : super(message);
}

/// A generic failure for any error that doesn't fit into the other categories.
class UnknownFailure extends Failure {
  const UnknownFailure({String message = 'An unknown error occurred.'}) : super(message);
}

/// A generic failure for authentication-related issues.
class AuthFailure extends Failure {
  const AuthFailure({String message = 'An authentication error occurred. Please try again.'}) : super(message);
}

/// Represents a failure where the user is not authenticated.
class UnauthenticatedFailure extends Failure {
  const UnauthenticatedFailure({String message = 'You must be logged in to perform this action.'}) : super(message);
}

/// Similar to UnauthorizedFailure but a more specific name for permission-related issues.
class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure({String message = 'Permission denied to perform this action.'}) : super(message);
}

/// Represents a timeout failure during a network request.
class TimeoutFailure extends Failure {
  const TimeoutFailure({String message = 'The request timed out. Please try again.'}) : super(message);
}

/// Represents a conflict with the current state of a resource (e.g., trying to create a user that already exists).
class ConflictFailure extends Failure {
  const ConflictFailure({String message = 'A conflict occurred with the current data. Please try again.'}) : super(message);
}

/// Represents a bad request failure (e.g., malformed syntax or invalid parameters).
class BadRequestFailure extends Failure {
  const BadRequestFailure({String message = 'The request was invalid. Please check your information.'}) : super(message);
}

/// Represents a failure when the service is temporarily unavailable.
class ServiceUnavailableFailure extends Failure {
  const ServiceUnavailableFailure({String message = 'Service is currently unavailable. Please try again later.'}) : super(message);
}