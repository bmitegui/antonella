import 'package:antonella/core/error/error.dart';
import 'package:dio/dio.dart';

extension DioResponseExtensions on Response {
  bool get isSuccess => data['status'] == 'success';

  T parseOrThrow<T>(T Function(dynamic data) parser) {
    if (isSuccess) {
      return parser(data['data']);
    } else {
      throw ServerException(message: data['message']);
    }
  }
}

mixin RemoteRequestHelper {
  Options get defaultOptions => Options(
        contentType: Headers.jsonContentType,
        validateStatus: (status) => status != null && status < 500,
      );

  Future<T> handleRequest<T>(
      {required Future<Response> Function() request,
      required T Function(dynamic data) onSuccess}) async {
    try {
      final response = await request();
      return response.parseOrThrow(onSuccess);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException(
            message: 'Error de conexión: tiempo de espera agotado.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw ServerException(
            message: 'No se pudo establecer conexión con el servidor.');
      } else {
        throw ServerException(message: 'Error de red: ${e.message}');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
