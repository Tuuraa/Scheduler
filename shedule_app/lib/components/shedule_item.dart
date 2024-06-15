import 'package:flutter/material.dart';
import 'package:shedule_app/models/shedule.dart';

class SheduleItem extends StatelessWidget {
  SheduleItem(
      {super.key,
      required this.lessonNumber,
      required this.startAnimation,
      required this.shedule});

  String truncateString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength - 3) + '...';
    }
  }

  final int lessonNumber;
  final Schedule shedule;
  bool startAnimation;
  double screenWidth = 0;
  static final Color black = Color(0xFF181818);
  static final Color green = Color.fromRGBO(18, 231, 213, 1);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300 + ((lessonNumber - 1) * 120)),
      transform:
          Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
      margin: const EdgeInsets.only(bottom: 7, right: 7, left: 7),
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, top: 2, right: 7, bottom: 2),
                    decoration: BoxDecoration(
                        color: black,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Text("$lessonNumber",
                        style: TextStyle(color: green, fontSize: 14)),
                  ),
                  const SizedBox(width: 15),
                  Text("${shedule.type}", style: TextStyle(fontSize: 14))
                ]),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    truncateString(shedule.name, 25),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Text(shedule.teacherName, style: TextStyle(fontSize: 13)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(shedule.audience),
                ),
              ],
            ),
            const Spacer(),
            Text(shedule.getFormattedTime(),
                style: const TextStyle(fontSize: 15))
          ],
        ),
      ),
    );
  }
}
