import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/user/data/models/models.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> signIn({
    required String account,
    required String password,
    required bool rememberMe,
  });
  Future<Either<Failure, UserModel>> getAdmin();
  Future<Either<Failure, UserModel>> signUp(
      {required String account,
      required String dni,
      required String name,
      required String password,
      required String birthdate,
      required String? genero,
      required String phoneNumber});
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, List<String>>> passwordCode({required String email});
  Future<Either<Failure, void>> passwordReset(
      {required String id, required String password});
  Future<Either<Failure, EmployeeInfoModel>> getEmployeeInfo(
      {required String employeeId,
      required String startDate,
      required String endDate});
  Future<Either<Failure, List<MessageModel>>> getMessages();
  Future<Either<Failure, void>> sendMessage(
      {required String userId,
      required String content,
      required MessageType type});
  Future<Either<Failure, UserModel>> updateProfile(
      {required String userId,
      required String? base64Photo,
      required String? name,
      required String? phoneNumber,
      required String? gmail});
  Future<Either<Failure, List<UserModel>>> getEmployees(
      {required ServiceType serviceType});
  Future<Either<Failure, void>> addCard(
      {required String userId,
      required String number,
      required int expiryMonth,
      required int expiryYear,
      required String cvc});
  Future<Either<Failure, void>> debitCard(
      {required String cardId,
      required String orderId,
      required double taxableAmount});
  Future<Either<Failure, List<CardModel>>> getCards({required String userId});
  Future<Either<Failure, List<ScheduleModel>>> getEmployeeBusySchedule(
      {required String employeeId});
}
