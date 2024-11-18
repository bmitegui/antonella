import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/data/models/models.dart';
import 'package:dio/dio.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signIn({
    required String email,
    required String password,
  });
  Future<UserModel> signUp({
    required String email,
    required String name,
    required String password,
    required String birthdate,
  });
}

final data = {
  'id': 'hsdkjhakjasd',
  'email': 'bmite@gmail.com',
  'name': 'Brian',
  'birthdate': '2001-05-11',
  'number': null,
  'cedula': null
};

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      final result = await client.post(Environment.signIn,
          data: {'account': email, 'password': password},
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
      {required String email,
      required String name,
      required String password,
      required String birthdate}) async {
    try {
      final result = await client.post(Environment.signUp,
          data: {
            'account': email,
            'name': name,
            'password': password,
            'birthdate': birthdate
          },
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
}
