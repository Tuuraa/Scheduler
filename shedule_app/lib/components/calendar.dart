import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class CustomCalendar extends StatefulWidget {
  CustomCalendar(
      {super.key,
      required this.focusDay,
      required this.selectedDay,
      required this.onSelectedDayChange});

  DateTime? selectedDay;
  DateTime focusDay;

  void Function(DateTime, DateTime)? onSelectedDayChange;

  static final Color black = const Color(0xFF181818);
  static final Color green = const Color.fromRGBO(18, 231, 213, 1);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {

  DateTime getCurrentMonday() {
    DateTime date = DateTime.now();
    int difference = date.weekday - DateTime.monday;

    return date.subtract(Duration(days: difference));
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarFormat: CalendarFormat.week,
      headerVisible: false,
      daysOfWeekVisible: true,
      focusedDay: widget.focusDay,
      firstDay: getCurrentMonday(),
      lastDay: DateTime.now().add(const Duration(days: 14)),
      selectedDayPredicate: (day) {
        return isSameDay(widget.selectedDay, day);
      },
      onDaySelected: widget.onSelectedDayChange,
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              '${date.day}',
              style: const TextStyle(fontSize: 15),
            ),
          );
        },
        todayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              '${date.day}',
              style: const TextStyle(fontSize: 17),
            ),
          );
        },
        selectedBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: CustomCalendar.black,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${date.day}',
              style: TextStyle(color: CustomCalendar.green, fontSize: 17),
            ),
          );
        },
        dowBuilder: (context, day) {
          final text = DateFormat.E().format(day);

          return Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),
            ),
          );
        },
      ),
    );
  }
}
