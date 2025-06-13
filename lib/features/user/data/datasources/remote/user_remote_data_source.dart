import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/data/models/models.dart';
import 'package:dio/dio.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signIn({
    required String account,
    required String password,
  });
  Future<UserModel> signUp(
      {required String account,
      required String dni,
      required String name,
      required String password,
      required String birthdate,
      required String phoneNumber,
      required String? genero});
  Future<List<String>> passwordCode({required String email});
  Future<void> passwordReset({required String id, required String password});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> signIn(
      {required String account, required String password}) async {
    try {
      final result = await client.post(Environment.signIn,
          data: {'phone_number': account, 'password': password},
          options: Options(
              contentType: Headers.jsonContentType,
              validateStatus: (status) => status != null && status < 500));

      final status = result.data['status'];

      if (status == 'success') {
        return UserModel.fromJson(result.data['data']);
      } else {
        throw ServerException(message: result.data['message']);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }

  @override
  Future<UserModel> signUp(
      {required String account,
      required String dni,
      required String name,
      required String password,
      required String birthdate,
      required String phoneNumber,
      required String? genero}) async {
    try {
      final data = {
        'email': account,
        'dni': dni,
        'name': name,
        'password': password,
        'birthdate': birthdate,
        'gender': genero?.toUpperCase(),
        'phone_number': phoneNumber
      };
      final result = await client.post(Environment.signUp,
          data: data,
          options: Options(
              contentType: Headers.jsonContentType,
              validateStatus: (status) => status != null && status < 500));
      final status = result.data['status'];
      if (status == 'success') {
        return UserModel.fromJson(result.data['data']);
      } else {
        throw ServerException(message: result.data['message']);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }

  @override
  Future<List<String>> passwordCode({required String email}) async {
    try {
      final url = '${Environment.passwordCode}?email=$email';
      final result = await client.post(url,
          options: Options(
              contentType: Headers.jsonContentType,
              validateStatus: (status) => status != null && status < 500));
      final status = result.data['status'];
      if (status == 'success') {
        return [result.data['data']['code'], result.data['data']['user_id']];
      } else {
        throw ServerException(message: result.data['message']);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }

  @override
  Future<void> passwordReset(
      {required String id, required String password}) async {
    try {
      final result = await client.put(Environment.signUp,
          data: {'id': id, 'password': password},
          options: Options(
              contentType: Headers.jsonContentType,
              validateStatus: (status) => status != null && status < 500));
      final status = result.data['status'];
      if (status == 'success') {
        return;
      } else {
        throw ServerException(message: result.data['message']);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }
}
