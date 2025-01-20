import 'package:flutter/material.dart';
import 'package:sheduler/components/shedule_item.dart';
import 'package:sheduler/models/day_shedule.dart';
import 'main_page.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  String searchTitle = "";
  final List<DaySchedule> _shcList = [];
  List<DaySchedule> _foundShc = [];

  @override
  void initState() {
    super.initState();
    _initializeScheduleList();
  }

  void updateFoundList(String value) {
    setState(() {
      searchTitle = value.toLowerCase().trim();
    });

    if (value.isEmpty) {
      _foundShc = List.from(_shcList);
    } else {
      List<DaySchedule> temp = [];
      for (var day in _shcList) {
        var matchingLessons = day.lessonList.where((schedule) {
          return schedule.name.toLowerCase().contains(searchTitle) ||
              schedule.teacherName.toLowerCase().contains(searchTitle);
        }).toList();

        if (matchingLessons.isNotEmpty) {
          temp.add(DaySchedule(day: day.day, lessons: matchingLessons));
        }
      }

      setState(() {
        _foundShc = temp;
      });
    }
  }

  void _initializeScheduleList() {
    for (var week in total_schedules) {
      for (var element in week.daysSchedule) {
        DaySchedule temp = DaySchedule(
            day: "${element.day}, ${week.weekIso}",
            lessons: element.lessonList);
        _shcList.add(temp);
      }
    }

    _foundShc = List.from(_shcList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchAnchor(
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) => [],
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onChanged: (value) {
                    updateFoundList(value);
                  },
                  leading: const Icon(Icons.search),
                );
              },
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _foundShc.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 15),
                          child: Text(_foundShc[index].day,
                              style: const TextStyle(fontSize: 16))),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _foundShc[index].lessonList.length,
                        itemBuilder: (context, lesIndex) {
                          return SheduleItem(
                            isNow: false,
                            lessonNumber: lesIndex + 1,
                            startAnimation: true,
                            shedule: _foundShc[index].lessonList[lesIndex],
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
