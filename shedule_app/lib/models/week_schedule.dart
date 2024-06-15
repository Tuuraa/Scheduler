import 'package:shedule_app/models/day_shedule.dart';

class WeekSchedule {
  String weekIso;
  List<DaySchedule> daysSchedule;

  WeekSchedule({required this.weekIso, required this.daysSchedule});
}
