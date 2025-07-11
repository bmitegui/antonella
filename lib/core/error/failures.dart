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

class ModelNotFoundFailure extends Failure {
  ModelNotFoundFailure({super.message});
}

class InvalidUserEmailFailure extends Failure {
  InvalidUserEmailFailure({super.message});
}

class InvalidUserBirthdateFailure extends Failure {}

class UserAlreadyExistsFailure extends Failure {}

class InvalidUserNameFailure extends Failure {}

class InvalidDniFailure extends Failure {}

class InvalidPhoneNumberFailure extends Failure {}

class InvalidUserPasswordFailure extends Failure {}
