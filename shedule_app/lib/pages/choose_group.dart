import 'package:flutter/material.dart';

class ChooseGroup extends StatelessWidget {
  const ChooseGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Text(
              textAlign: TextAlign.center,
              "Здесь вы сможете выбирать группу. Данный раздел еще в разработке",
              style: TextStyle(fontSize: 18))),
    );
  }
}
