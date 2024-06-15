import 'package:flutter/material.dart';
import 'package:shedule_app/components/shedule_item.dart';
import 'package:shedule_app/models/day_shedule.dart';
import 'package:shedule_app/pr2_schedule/total_list.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  String searchTitle = "";
  List<DaySchedule> _shcList = [];
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
      List<DaySchedule> _temp = [];
      _shcList.forEach((day) {
        var matchingLessons = day.lessonList.where((schedule) {
          return schedule.name.toLowerCase().contains(searchTitle) ||
              schedule.teacherName.toLowerCase().contains(searchTitle);
        }).toList();

        if (matchingLessons.isNotEmpty) {
          _temp.add(DaySchedule(day: day.day, lessons: matchingLessons));
        }
      });

      print("TEMP IS $_temp");
      setState(() {
        _foundShc = _temp;
      });
    }
  }

  void _initializeScheduleList() {
    total_schedule.forEach((week) {
      week.daysSchedule.forEach((element) {
        DaySchedule temp = DaySchedule(
            day: element.day + ", ${week.weekIso}",
            lessons: element.lessonList);
        _shcList.add(temp);
      });
    });

    _foundShc = List.from(_shcList); // Ensure a new list is assigned
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
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
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
