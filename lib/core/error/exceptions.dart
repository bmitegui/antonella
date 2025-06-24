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

class IncompleteFieldsException implements Exception {
  IncompleteFieldsException();
}

class ModelNotFoundException implements Exception {
  ModelNotFoundException();
}
