class ServerException implements Exception {
  final String message;
  const ServerException({this.message = 'Excepción del servidor'});
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = 'Excepción de caché'});
}
