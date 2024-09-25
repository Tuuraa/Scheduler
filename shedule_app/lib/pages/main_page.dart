import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shedule_app/components/calendar.dart';
import 'package:shedule_app/components/day_off.dart';
import 'package:shedule_app/components/shedule_item.dart';
import 'package:shedule_app/pages/choose_group.dart';
import 'package:shedule_app/pages/search_page.dart';
import 'package:shedule_app/pr2_schedule/total_list.dart';

class LaunchApp extends StatefulWidget {
  const LaunchApp({super.key});

  @override
  State<LaunchApp> createState() => _LaunchAppState();
}

class _LaunchAppState extends State<LaunchApp> {
  List<String> weekdays = [
    "Понедельник",
    "Вторник",
    "Среда",
    "Четверг",
    "Пятница",
    "Суббота",
    "Воскресенье"
  ];
  DateTime? _selectedDay;
  DateTime _focusDay = DateTime.now();
  bool startAnimation = false;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _focusDay.weekday - 1);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  void setSelectedDay(DateTime? selDay, DateTime focDay) {
    setState(() {
      _selectedDay = selDay;
      _focusDay = focDay;

      _pageController.jumpToPage(focDay.weekday - 1);
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "SCHEDULER",
          style: GoogleFonts.acme(fontSize: 28),
        ),
        // leading: IconButton(
        //   onPressed: () => Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => ChooseGroup())),
        //   icon: const Icon(Icons.bookmark),
        // ),
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
            "Сегодня: ${DateFormat('d MMMM', 'ru').format(DateTime.now())}, ${getStringWeekNumber()}",
            style: const TextStyle(
              fontSize: 17,
              color: Color.fromRGBO(0, 0, 0, 0.8),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              itemCount: 14,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  var newDate = DateTime.now()
                      .subtract(Duration(days: DateTime.now().weekday - 1 - index));
                  _focusDay = newDate;
                  _selectedDay = newDate;
                });
              },
              itemBuilder: (context, index) {
                DateTime pageDay = DateTime.now()
                    .subtract(Duration(days: DateTime.now().weekday - 1 - index));

                List lessons = total_schedule[getEvenWeek(pageDay)]
                    .daysSchedule[pageDay.weekday - 1]
                    .lessons;
                if (lessons.isEmpty) {
                  return const DayOff();
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: lessons.length,
                        itemBuilder: (context, ind) {
                          Duration startLesson = lessons[ind].startLess;
                          Duration endLesson = lessons[ind].endLess;

                          DateTime now = DateTime.now();
                          Duration nowDuration =
                              Duration(hours: now.hour + 3, minutes: now.minute);
                          bool isCurrentLesson =
                              weekdays[pageDay.weekday - 1] ==
                                  weekdays[now.weekday - 1] &&
                                  (nowDuration >= startLesson &&
                                      nowDuration <= endLesson) &&
                                  total_schedule[getEvenWeek(pageDay)]
                                          .weekIso ==
                                      getStringWeekNumber().split(' ')[0];

                          return SheduleItem(
                            isNow: isCurrentLesson,
                            startAnimation: startAnimation,
                            lessonNumber: ind + 1,
                            shedule: lessons[ind],
                          );
                        },
                      ),
                    ),
                  ],
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
    );
  }
}
