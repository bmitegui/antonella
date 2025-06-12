import 'package:antonella/features/service/domain/entities/entities.dart';

class ServiceFormModel extends ServiceFormEntity {
  const ServiceFormModel(
      {required super.id,
      required super.title,
      required super.type,
      required super.urlPhotos,
      required super.answer});

  factory ServiceFormModel.fromJson(Map<String, dynamic> json) {
    final type = json['type'] ?? '';
    final urlPhotos = json['urlPhotos'];
    return ServiceFormModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        type: type,
        urlPhotos: urlPhotos,
        answer: type == 'selectPhotos'
            ? (urlPhotos as Map<String, String>).keys.toList()[0]
            : type == 'isSelected'
                ? 'Sí'
                : null);
  }

  ServiceFormModel copyWith({
    String? id,
    String? title,
    String? type,
    Map<String, String>? urlPhotos,
    dynamic answer,
  }) {
    return ServiceFormModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      urlPhotos: urlPhotos ?? this.urlPhotos,
      answer: answer,
    );
  }
}
