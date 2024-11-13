class UserEntity {
  final String id;
  final String email;
  final String name;
  final DateTime birthdate;
  final String? number;
  final String? cedula;

  UserEntity(
      {required this.id,
      required this.email,
      required this.name,
      required this.birthdate,
      required this.number,
      required this.cedula});
}
