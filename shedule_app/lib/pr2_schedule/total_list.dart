import 'package:shedule_app/models/day_shedule.dart';
import 'package:shedule_app/models/week_schedule.dart';
import 'package:shedule_app/pr2_schedule/even_week.dart';
import 'package:shedule_app/pr2_schedule/odd_week.dart';

List<DaySchedule> odd_shedules = [
  mondaySchedule,
  tuesdaySchedule,
  wednesdaySchedule,
  thursdaySchedule,
  fridaySchedule,
  saturdaySchedule,
  sundaySchedule
];

List<DaySchedule> even_schedules = [
  mondayScheduleOdd,
  tuesdayScheduleOdd,
  wednesdayScheduleOdd,
  thursdayScheduleOdd,
  fridayScheduleOdd,
  saturdayScheduleOdd,
  sundayScheduleOdd,
  saturdayScheduleOdd
];

WeekSchedule odd_week =
    WeekSchedule(weekIso: "Четная", daysSchedule: odd_shedules);

WeekSchedule even_week =
    WeekSchedule(weekIso: "Нечетная", daysSchedule: even_schedules);

List<WeekSchedule> total_schedule = [odd_week, even_week];

