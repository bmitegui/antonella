import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.dni,
      required super.phoneNumber,
      required super.email,
      required super.name,
      required super.gender,
      required super.birthdate,
      required super.createdDate,
      required super.rol,
      required super.photoUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rol = json["categories"] != null ? Rol.empleado : Rol.cliente;
    return UserModel(
        id: json['id'],
        dni: json['dni'],
        phoneNumber: json['phone_number'],
        email: json['email'],
        name: capitalize(json['name']),
        gender: stringToGender(json['gender']),
        birthdate: parseStringToDate(json['birthdate']),
        createdDate: parseStringToDate(
          json['created_date'],
        ),
        rol: rol,
        photoUrl: json['photo']);
  }
}

String genderToString(Gender gender) {
  return gender == Gender.masculino ? 'MASCULINO' : 'FEMENINO';
}

Gender stringToGender(String gender) {
  return gender == 'MASCULINO' ? Gender.masculino : Gender.femenino;
}
