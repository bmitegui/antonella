import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/services/key_value_storage_service_impl.dart';
import 'package:antonella/core/utils/remote_data_source_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/user/data/models/models.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:dio/dio.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signIn({
    required String account,
    required String password,
  });
  Future<UserModel> getAdmin();
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
  Future<List<MessageModel>> getMessages();
  Future<void> sendMessage(
      {required String userId,
      required String content,
      required MessageType type});
  Future<void> addProfile({required String id, required String urlPhoto});
  Future<void> signOut();
}

class UserRemoteDataSourceImpl
    with RemoteRequestHelper
    implements UserRemoteDataSource {
  final Dio client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> signIn(
      {required String account, required String password}) async {
    final user = await handleRequest(
        request: () => client.post(Environment.signIn,
            data: {'phone_number': account, 'password': password},
            options: defaultOptions),
        onSuccess: (data) => UserModel.fromJson(data));

    final fcmToken =
        await sl<KeyValueStorageServiceImpl>().getValue<String>('fcmToken');
    await handleRequest(
        request: () => client.post(Environment.fcmToken,
            data: {'user_id': user.id, 'token': fcmToken}),
        onSuccess: (_) {});
    return user;
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
    final user = await handleRequest(
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

    final fcmToken =
        await sl<KeyValueStorageServiceImpl>().getValue<String>('fcmToken');
    await handleRequest(
        request: () => client.post(Environment.fcmToken,
            data: {'user_id': user.id, 'token': fcmToken}),
        onSuccess: (_) {});
    return user;
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
  Future<List<MessageModel>> getMessages() async {
    String userId = "";
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      userId = userState.user.id;
    }
    final url = '${Environment.chat}?user_id=$userId';

    return await handleRequest(
        request: () => client.get(url, options: defaultOptions),
        onSuccess: (data) {
          if (data is! List) {
            return [];
          } else {
            return data
                .map<MessageModel>(
                    (messageJson) => MessageModel.fromJson(messageJson))
                .toList();
          }
        });
  }

  @override
  Future<void> sendMessage(
      {required String userId,
      required String content,
      required MessageType type}) async {
    return await handleRequest(
        request: () => client.post(Environment.userChatMessage,
            data: {
              "user_id": userId,
              "content": content,
              "message_type": messageTypeToString(type)
            },
            options: defaultOptions),
        onSuccess: (_) {});
  }

  @override
  Future<void> addProfile(
      {required String id, required String urlPhoto}) async {
    return await handleRequest(
        request: () => client.put(Environment.signUp,
            data: {'id': id, 'photo': urlPhoto}, options: defaultOptions),
        onSuccess: (_) {});
  }

  @override
  Future<void> signOut() async {
    String userId = "";
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      userId = userState.user.id;
    }
    final url = '${Environment.fcmToken}?user_id=$userId';
    return await handleRequest(
        request: () => client.delete(url, options: defaultOptions),
        onSuccess: (_) {});
  }

  @override
  Future<UserModel> getAdmin() async {
    return await handleRequest(
        request: () => client.get(Environment.admin, options: defaultOptions),
        onSuccess: (data) => UserModel.fromJson(data));
  }
}
