import 'package:equatable/equatable.dart';

class ServiceFormEntity extends Equatable {
  final String id;
  final String title;
  final String type;
  final Map<String, String>? urlPhotos;
  final dynamic answer;

  const ServiceFormEntity(
      {required this.id,
      required this.title,
      required this.type,
      required this.urlPhotos,
      required this.answer});

  @override
  List<Object?> get props => [id];
}
