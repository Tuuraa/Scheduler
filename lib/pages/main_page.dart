import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:sheduler/config.dart';
import 'package:sheduler/models/day_shedule.dart';
import 'package:sheduler/models/shedule.dart';
import 'package:sheduler/models/week_schedule.dart';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sheduler/components/calendar.dart';
import 'package:sheduler/components/day_off.dart';
import 'package:sheduler/components/shedule_item.dart';
import 'package:sheduler/pages/choose_group.dart';
import 'package:sheduler/pages/search_page.dart';
import 'package:sheduler/utils/setup.dart';

List<WeekSchedule> total_schedules = [];

class LaunchApp extends StatefulWidget {
  const LaunchApp({super.key});

  @override
  State<LaunchApp> createState() => _LaunchAppState();
}

class _LaunchAppState extends State<LaunchApp> {
  static List<String> weekdays = [
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
    _fetchSchedules();

  }

  Future<void> _fetchSchedules() async {
    try {
      List<WeekSchedule> schedules = await getSchedule();
      setState(() {
        total_schedules = schedules; 
        startAnimation = true;  
        _selectedDay = _focusDay;
      });
    } catch (e) {
      print('Error fetching schedules: $e');
    }
  }
  Future<void> updateLessons() async {
    await _fetchSchedules();
  }
  void setSelectedDay(DateTime? selDay, DateTime focDay) {
    DateTime nextMonday = DateTime.now().add(Duration(days: 7 - DateTime.now().weekday));
    bool isNextWeek = focDay.isAfter(nextMonday);

    setState(() {
      _selectedDay = selDay;
      _focusDay = focDay;

      if (isNextWeek) {
        _pageController.jumpToPage(focDay.weekday - 1 + 7);
      }
      else {
        _pageController.jumpToPage(focDay.weekday - 1);
      }
      
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
      leading: IconButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChooseGroup(updateSchedulerList: updateLessons))),
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

              if (total_schedules.isEmpty) {
                return const DayOff();
              }

              int evenWeek = getEvenWeek(pageDay);
              if (evenWeek < 0 || evenWeek >= total_schedules.length) {
                return const DayOff(); 
              }
              var less = total_schedules[evenWeek].daysSchedule;
              List<Schedule> lessons = [];
              //[pageDay.weekday - 1]
                  // .lessons;

              if (less[pageDay.weekday - 1].lessons.isEmpty) {
                return const DayOff();
              }
              else {
               lessons = less[pageDay.weekday - 1].lessons;
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
                            Duration(hours: now.hour, minutes: now.minute);
                        bool isCurrentLesson =
                            weekdays[pageDay.weekday - 1] ==
                                    weekdays[now.weekday - 1] &&
                                (nowDuration >= startLesson &&
                                    nowDuration <= endLesson) &&
                                total_schedules[evenWeek]
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


Schedule addDaySchedule(String currentLesson, List<String> currentLessonsInfo) {
    var temp = currentLesson.split("/");
    var lessonTime = temp[0].split(RegExp(r'[(),;\s]+'));

   var startLess = lessonTime[2].split(":");
   var endLess = lessonTime[4].split(":");
   //print("object");
   return Schedule(
      type: temp[2].trim(), 
      name: temp[1].trim(), 
      teacherName:  [currentLessonsInfo[1], currentLessonsInfo[2], currentLessonsInfo[3]].join(" "), 
      audience: currentLessonsInfo[5], 
      startLess:Duration(hours: int.parse(startLess[0]), minutes: int.parse(startLess[1])), 
      endLess: Duration(hours: int.parse(endLess[0]), minutes: int.parse(endLess[1]))
   );
  }

  Future<List<WeekSchedule>> getSchedule() async {
    await SetupData.initData();
    HttpOverrides.global = MyHttpOverrides();
    List<WeekSchedule> shedules = [];


    String currentWeekType;
    String currentDay;
    WeekSchedule? week;
    DaySchedule? day;
    print(Config.selectedGroup);
    String url =
        'https://elkaf.kubstu.ru/timetable/default/time-table-student-ofo?iskiosk=0&fak_id=${Config.getKeyByValueInList(Config.selectedInst)}&kurs=${Config.selectedCurs}&gr=${Config.selectedGroup}&ugod=${DateTime.now().year - 1}&semestr=${Config.selectedSemester}';
    print(Config.selectedGroup);
    try {
      final response = await http.get(Uri.parse(url));
      print("FETCHING");
      if (response.statusCode == 200) {
        var document = html.parse(response.body);
        int n = 0, d = 1, i = 1;
        var panelTitleElements = document.getElementsByClassName('panel-title');
        for (var item in panelTitleElements) {

          var panelCollapseElements = document.getElementById('collapse_n_${n}_d_${d}_i_${i}')?.getElementsByClassName("panel-body");
          var currentLessonsInfo = panelCollapseElements?.first.text.replaceAll(RegExp(r'\s+'), ' ').trim().split(" ");
          
          final String currentLesson = item.text.trim();
          if (!["Нечетная", "Четная"].contains(currentLesson)) {
            if (!weekdays.contains(currentLesson)) {
              if (week != null && day != null && currentLessonsInfo != null) {
                day.lessonList.add(addDaySchedule(currentLesson, currentLessonsInfo));
                i+=1;
              }
            }
            else {
              if (day != null){
                week?.daysSchedule.add(day);
                day = null;
                d+=1;
                i=1;
              }

              currentDay = currentLesson;
              day = DaySchedule(day: currentDay, lessons: []);
            }
          }
          else {
            if (week != null){
              if (day != null) {
                week.daysSchedule.add(day);
              }
              shedules.add(week);
              for(int i = week.daysSchedule.length; i < 7; i++) {
                week.daysSchedule.add(DaySchedule(day: weekdays[i], lessons: []));
              }
              week = null;
            }
            currentWeekType = currentLesson.split(" ")[0];
            n+=1;
            d=1;
            i=1;
            week = WeekSchedule(weekIso: currentWeekType, daysSchedule: []);
          }
        }
        if (week != null){
          for(int i = week.daysSchedule.length; i < 7; i++) {
                week.daysSchedule.add(DaySchedule(day: weekdays[i], lessons: []));
            }
          shedules.add(week);
        }
        return shedules;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return [];
  }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
