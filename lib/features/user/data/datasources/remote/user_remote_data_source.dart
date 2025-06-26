import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/remote_data_source_util.dart';
import 'package:antonella/features/user/data/models/models.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
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
  Future<EmployeeInfoModel> getEmployeeInfo(
      {required String employeeId,
      required String startDate,
      required String endDate});
  Future<MessageModel> getMessages();
}

class UserRemoteDataSourceImpl
    with RemoteRequestHelper
    implements UserRemoteDataSource {
  final Dio client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> signIn(
      {required String account, required String password}) async {
    return await handleRequest(
        request: () => client.post(Environment.signIn,
            data: {'phone_number': account, 'password': password},
            options: defaultOptions),
        onSuccess: (data) => UserModel.fromJson(data));
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
    return await handleRequest(
        request: () => client.post(Environment.signUp,
            data: {
              'email': account,
              'dni': dni,
              'name': name,
              'password': password,
              'birthdate': birthdate,
              'gender': genero?.toUpperCase(),
              'phone_number': phoneNumber
            },
            options: defaultOptions),
        onSuccess: (data) => UserModel.fromJson(data));
  }

  @override
  Future<List<String>> passwordCode({required String email}) async {
    final url = '${Environment.passwordCode}?email=$email';
    return handleRequest(
        request: () => client.post(url, options: defaultOptions),
        onSuccess: (data) => [data['code'], data['user_id']]);
  }

  @override
  Future<void> passwordReset(
      {required String id, required String password}) async {
    return await handleRequest(
        request: () => client.put(Environment.signUp,
            data: {'id': id, 'password': password}, options: defaultOptions),
        onSuccess: (_) {});
  }

  @override
  Future<EmployeeInfoModel> getEmployeeInfo(
      {required String employeeId,
      required String startDate,
      required String endDate}) async {
    return await handleRequest(
        request: () => client.post(Environment.employeeInfo,
            data: {
              "employee_id": employeeId,
              "start_date": startDate,
              "end_date": endDate
            },
            options: defaultOptions),
        onSuccess: (data) => EmployeeInfoModel.fromJson(data));
  }

  @override
  Future<MessageModel> getMessages() async {
    String userId = "";
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      userId = userState.user.id;
    }
    final url = '${Environment.chat}?user_id=$userId';

    return await handleRequest(
        request: () => client.get(url, options: defaultOptions),
        onSuccess: (data) => MessageModel.fromJson(data));
  }
}
