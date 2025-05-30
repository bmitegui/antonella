import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.phoneNumber,
      required super.email,
      required super.name,
      required super.gender,
      required super.birthdate,
      required super.createdDate});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        phoneNumber: json['phone_number'],
        email: json['email'],
        name: json['name'],
        gender: stringToGender(json['gender']),
        birthdate: parseStringToDate(json['birthdate']),
        createdDate: parseStringToDate(json['created_date']));
  }
}

String genderToString(Gender gender) {
  return gender == Gender.masculino ? 'MASCULINO' : 'FEMENINO';
}

Gender stringToGender(String gender) {
  return gender == 'MASCULINO' ? Gender.masculino : Gender.femenino;
}
