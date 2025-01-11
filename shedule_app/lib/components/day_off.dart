import 'package:flutter/material.dart';

class DayOff extends StatelessWidget {
  const DayOff({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Column(
        children: [
          Image.asset(
            "assets/images/sleeping_man.png",
            width: 360,
            height: 360,
          ),
          const Text(
            'В этот день выходной', 
            style: TextStyle(fontSize: 20)
          ),
        ],
      ),
    );
  }
}