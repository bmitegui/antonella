abstract class Failure {
  final String? message;
  Failure({this.message});
}

class ServerFailure extends Failure {
  ServerFailure({super.message});
}

class CacheFailure extends Failure {
  CacheFailure({super.message});
}

class NetworkConnectionFailure extends Failure {
  NetworkConnectionFailure({super.message});
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure({super.message});
}

class IncorrectPasswordFailure extends Failure {
  IncorrectPasswordFailure({super.message});
}

class IncompleteFieldsFailure extends Failure {
  IncompleteFieldsFailure({super.message});
}

class ModelNotFoundFailure implements Exception {
  ModelNotFoundFailure();
}