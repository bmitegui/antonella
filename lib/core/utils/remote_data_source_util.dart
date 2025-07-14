import 'package:antonella/core/error/error.dart';
import 'package:dio/dio.dart';

extension DioResponseExtensions on Response {
  bool get isSuccess => data['status'] == 'success';

  T parseOrThrow<T>(T Function(dynamic data) parser) {
    if (isSuccess) {
      return parser(data['data']);
    } else {
      final exception = data['error'];
      throw getException(exception: exception);
    }
  }
}

Exception getException({required String exception}) {
  return (exception == 'Exception')
      ? IncompleteFieldsException()
      : (exception == 'ModelNotFoundException')
          ? ModelNotFoundException()
          : (exception == 'IncorrectPasswordException')
              ? IncorrectPasswordException()
              : (exception == 'InvalidUserEmailException')
                  ? InvalidUserEmailException()
                  : (exception == 'InvalidUserBirthdateException')
                      ? InvalidUserBirthdateException()
                      : (exception == 'UserAlreadyExistsException')
                          ? UserAlreadyExistsException()
                          : (exception == 'InvalidUserNameException')
                              ? InvalidUserNameException()
                              : (exception == 'InvalidDniException')
                                  ? InvalidDniException()
                                  : (exception == 'InvalidPhoneNumberException')
                                      ? InvalidPhoneNumberException()
                                      : (exception ==
                                              'InvalidUserPasswordException')
                                          ? InvalidUserPasswordException()
                                          : ServerException();
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
    } on NetworkConnectionException {
      rethrow;
    } on UnexpectedException {
      rethrow;
    } on IncorrectPasswordException {
      rethrow;
    } on IncompleteFieldsException {
      rethrow;
    } on IncorrectUserNameException {
      rethrow;
    } on InvalidUserEmailException {
      rethrow;
    } on InvalidUserBirthdateException {
      rethrow;
    } on UserAlreadyExistsException {
      rethrow;
    } on InvalidUserNameException {
      rethrow;
    } on InvalidDniException {
      rethrow;
    } on InvalidPhoneNumberException {
      rethrow;
    } on InvalidUserPasswordException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
