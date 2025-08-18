import 'package:antonella/features/user/domain/entities/entities.dart';

class ScheduleModel extends ScheduleEntity {
  ScheduleModel(
      {required super.day, required super.startTime, required super.endTime});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    final day = DateTime.parse(json["day"]);
    final start = DateTime.parse("${json["day"]} ${json["start_time"]}");
    final end = DateTime.parse("${json["day"]} ${json["end_time"]}");

    return ScheduleModel(
      day: day,
      startTime: start,
      endTime: end,
    );
  }
}
