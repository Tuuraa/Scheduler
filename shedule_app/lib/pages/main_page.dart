import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shedule_app/components/calendar.dart';
import 'package:shedule_app/components/shedule_item.dart';
import 'package:shedule_app/config.dart';
import 'package:shedule_app/pages/choose_group.dart';
import 'package:shedule_app/pages/search_page.dart';
import 'package:shedule_app/pr2_schedule/total_list.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(LaunchApp());
}

class LaunchApp extends StatefulWidget {
  const LaunchApp({super.key});

  @override
  State<LaunchApp> createState() => _LaunchAppState();
}

class _LaunchAppState extends State<LaunchApp> {
  DateTime? _selectedDay;
  DateTime _focusDay = DateTime.now();

  bool startAnimation = false;

  void setSelectedDay(DateTime? selDay, DateTime focDay) {
    setState(() {
      _selectedDay = selDay;
      _focusDay = focDay;
    });
    print(_focusDay.weekday);
  }

  int getEvenWeek(DateTime date) {
    final year = date.year;

    final firstDayOfYear = DateTime(year, 1, 1);
    final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;

    final weekNumber = (daysSinceFirstDay / 7).ceil();

    return weekNumber % 2 == 0 ? 0 : 1;
  }

  int getIsoWeekNumber() {
    final now = DateTime.now();
    final year = now.year;

    final firstDayOfYear = DateTime(year, 1, 1);
    final daysSinceFirstDay = now.difference(firstDayOfYear).inDays;

    final weekNumber = (daysSinceFirstDay / 7).ceil();

    return weekNumber % 2 == 0 ? 0 : 1;
  }

  String getStringWeekNumber() {
    int weekIndex = getIsoWeekNumber();

    return weekIndex == 0 ? "Четная неделя" : "Нечетная неделя";
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        centerTitle: true,
        title: Text(
          "SCHEDULER",
          style: GoogleFonts.acme(fontSize: 28),
        ),
        leading: IconButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChooseGroup())),
          icon: const Icon(Icons.bookmark),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CustomSearch()),
            ),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          CustomCalendar(
            onSelectedDayChange: (sDay, fDay) => setSelectedDay(sDay, fDay),
            focusDay: _focusDay,
            selectedDay: _selectedDay,
          ),
          const SizedBox(height: 5),
          Text(
            "${DateTime.now().day} ${DateFormat('MMMM').format(DateTime.now())}, ${getStringWeekNumber()}",
            style: const TextStyle(
              fontSize: 17,
              color: Color.fromRGBO(0, 0, 0, 0.8),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: total_schedule[getEvenWeek(_focusDay)]
                  .daysSchedule[_focusDay.weekday - 1]
                  .lessons
                  .length,
              itemBuilder: (context, index) {
                return SheduleItem(
                  startAnimation: startAnimation,
                  lessonNumber: index + 1,
                  shedule: total_schedule[getEvenWeek(_focusDay)]
                      .daysSchedule[_focusDay.weekday - 1]
                      .lessons[index],
                );
              },
            ),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Designed by Tura',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: NavigationBar(
      //   backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      //   destinations: [
      //     NavigationDestination(icon: Icon(Icons.menu), label: 'Расписание'),
      //     NavigationDestination(
      //         icon: Icon(Icons.account_circle), label: 'Профиль')
      //   ],
      // ),
    );
  }
}
