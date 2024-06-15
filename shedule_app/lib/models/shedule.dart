import 'package:intl/intl.dart';

class Schedule {
  final String type;
  final String name;
  final String teacherName;
  final String audience;
  final Duration startLess;
  final Duration endLess;

  Schedule({
    required this.type,
    required this.name,
    required this.teacherName,
    required this.audience,
    required this.startLess,
    required this.endLess,
  });

String formatTime(Duration duration) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, duration.inHours, duration.inMinutes % 60);
    return DateFormat.Hm().format(dateTime);
  }

  String getFormattedTime() {
    return "${formatTime(startLess)} - ${formatTime(endLess)}";
  }

}
