enum Gender { masculino, femenino }

class UserEntity {
  final String id;
  final String dni;
  final String phoneNumber;
  final String email;
  final String name;
  final Gender gender;
  final DateTime birthdate;
  final DateTime createdDate;

  UserEntity(
      {required this.id,
      required this.dni,
      required this.phoneNumber,
      required this.email,
      required this.name,
      required this.gender,
      required this.birthdate,
      required this.createdDate});
}
