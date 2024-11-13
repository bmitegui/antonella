abstract class Failure {
  final String message;
  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({super.message = 'Fallo del servidor'});
}

class CacheFailure extends Failure {
  CacheFailure({super.message = 'Fallo del caché'});
}
