enum Gender { masculino, femenino }

enum Rol { cliente, empleado }

class UserEntity {
  final String id;
  final String dni;
  final String phoneNumber;
  final String email;
  final String name;
  final Gender gender;
  final DateTime birthdate;
  final DateTime createdDate;
  final Rol rol;
  final String? photoUrl;

  UserEntity(
      {required this.id,
      required this.dni,
      required this.phoneNumber,
      required this.email,
      required this.name,
      required this.gender,
      required this.birthdate,
      required this.createdDate,
      required this.rol,
      required this.photoUrl});
}
