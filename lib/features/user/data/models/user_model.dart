import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.email,
      required super.name,
      required super.birthdate,
      required super.number,
      required super.cedula});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['account'],
      name: json['name'],
      birthdate: parseStringToDate(json['birthdate']),
      number: json['number'],
      cedula: json['cedula'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'birthdate': formatDateToString(birthdate),
      'number': number,
      'cedula': cedula,
    };
  }
}
