import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/services/key_value_storage_service_impl.dart';
import 'package:antonella/core/utils/remote_data_source_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
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
  Future<UserModel> updateProfile(
      {required String userId,
      required String? base64Photo,
      required String? name,
      required String? phoneNumber,
      required String? gmail});
  Future<void> signOut();
  Future<List<UserModel>> getEmployees({required ServiceType serviceType});
  Future<void> addCard(
      {required String userId,
      required String number,
      required int expiryMonth,
      required int expiryYear,
      required String cvc});
  Future<void> debitCard(
      {required String cardId,
      required String orderId,
      required double taxableAmount});
  Future<List<CardModel>> getCards({required String userId});
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

  @override
  Future<List<UserModel>> getEmployees(
      {required ServiceType serviceType}) async {
    final data = {
      "service_category": (serviceType == ServiceType.hair)
          ? "CABELLO"
          : (serviceType == ServiceType.nails)
              ? "UÑAS"
              : (serviceType == ServiceType.spa)
                  ? "SPA"
                  : "MAQUILLAJE"
    };
    return await handleRequest(
        request: () => client.post(Environment.userFilter,
            data: data, options: defaultOptions),
        onSuccess: (data) {
          final employeesData = data['users'];
          if (employeesData is! List) {
            return [];
          } else {
            return employeesData
                .map<UserModel>(
                    (employeeData) => UserModel.fromJson(employeeData))
                .toList();
          }
        });
  }

  @override
  Future<UserModel> updateProfile(
      {required String userId,
      required String? base64Photo,
      required String? name,
      required String? phoneNumber,
      required String? gmail}) async {
    final data = {
      "id": userId,
      if (phoneNumber != null) "phone_number": phoneNumber,
      if (name != null) "name": name,
      if (gmail != null) "email": gmail,
      if (base64Photo != null) "photo": base64Photo,
    };

    return await handleRequest(
        request: () =>
            client.put(Environment.signUp, data: data, options: defaultOptions),
        onSuccess: (data) => UserModel.fromJson(data));
  }

  @override
  Future<void> addCard(
      {required String userId,
      required String number,
      required int expiryMonth,
      required int expiryYear,
      required String cvc}) async {
    final data = {
      "user_id": userId,
      "number": number,
      "expiry_month": expiryMonth,
      "expiry_year": expiryYear,
      "cvc": cvc
    };
    return await handleRequest(
        request: () => client.post(Environment.addCard,
            data: data, options: defaultOptions),
        onSuccess: (_) {});
  }

  @override
  Future<void> debitCard(
      {required String cardId,
      required String orderId,
      required double taxableAmount}) async {
    final data = {
      "card_id": cardId,
      "order_id": orderId,
      "taxable_amount": taxableAmount
    };
    return await handleRequest(
        request: () =>
            client.post(Environment.debit, data: data, options: defaultOptions),
        onSuccess: (_) {});
  }

  @override
  Future<List<CardModel>> getCards({required String userId}) async {
    final url = '${Environment.payment}?user_id=$userId';
    return await handleRequest(
        request: () => client.get(url, options: defaultOptions),
        onSuccess: (data) {
          if (data is! List) {
            return [];
          } else {
            return data
                .map<CardModel>((cardData) => CardModel.fromJson(cardData))
                .toList();
          }
        });
  }
}
