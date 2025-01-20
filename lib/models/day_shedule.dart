import 'package:sheduler/models/shedule.dart';

class DaySchedule {
  String day;
  final List<Schedule> lessons;

  DaySchedule({required this.day, required this.lessons});

  List<Schedule> get lessonList => lessons;
}
