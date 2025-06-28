class ServerException implements Exception {
  final String? message;
  const ServerException({this.message = 'Excepción del servidor'});
}

class CacheException implements Exception {
  CacheException();
}

class NetworkConnectionException implements Exception {
  NetworkConnectionException();
}

class UnexpectedException implements Exception {
  UnexpectedException();
}

class IncorrectPasswordException implements Exception {
  IncorrectPasswordException();
}

class IncorrectUserNameException implements Exception {
  final String? message;
  IncorrectUserNameException({this.message = 'Nombre de usuario incorrecto'});
}

class IncompleteFieldsException implements Exception {
  IncompleteFieldsException();
}

class ModelNotFoundException implements Exception {
  ModelNotFoundException();
}
