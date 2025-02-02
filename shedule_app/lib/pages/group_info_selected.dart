import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:shedule_app/config.dart';
import 'package:shedule_app/utils/setup.dart';

class GroupInfo extends StatefulWidget {
  String selectedGroup;
  GroupInfo({super.key, required this.selectedGroup});
  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  List<String> _institutes = [];
  String? selectedInst;
  int selectedCurs = 1;
  int selectedSemester = 1; // Семестр по умолчанию

  @override
  void initState() {
    super.initState();
    _institutes = Config.institutes.map((e) => e.values.first ?? "").toList();
    selectedInst = _institutes.isNotEmpty ? _institutes.first : null;
    selectedCurs = 1;
  }

  void saveAllInfo() async {
    Config.selectedCurs = selectedCurs;
    Config.selectedGroup = widget.selectedGroup;
    Config.selectedInst = selectedInst;
    Config.selectedSemester = selectedSemester; // Сохраняем выбранный семестр

    SetupData.saveData({
      "group": widget.selectedGroup,
      "curs": selectedCurs,
      "inst": selectedInst,
      "semester": selectedSemester, // Сохраняем семестр
    });

    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Доп. информация")),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Выберите институт", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  alignment: Alignment.center,
                  value: selectedInst,
                  onChanged: (value) {
                    setState(() {
                      selectedInst = value;
                    });
                  },
                  items: _institutes.map((e) {
                    return DropdownMenuItem(
                        alignment: Alignment.center,
                        value: e,
                        child: Text(e,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal)));
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Выберите курс", style: TextStyle(fontSize: 18)),
              Container(
                width: 120,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: selectedCurs,
                  onChanged: (value) {
                    setState(() {
                      selectedCurs = value ?? 1;
                    });
                  },
                  items: [1, 2, 3, 4, 5, 6].map((e) {
                    return DropdownMenuItem(
                        alignment: Alignment.center,
                        value: e,
                        child: Text(
                          e.toString(),
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.normal),
                        ));
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Выберите семестр", style: TextStyle(fontSize: 18)),
              Container(
                width: 120,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: selectedSemester,
                  onChanged: (value) {
                    setState(() {
                      selectedSemester = value!;
                    });
                  },
                  items: [1, 2].map((e) {
                    return DropdownMenuItem(
                        alignment: Alignment.center,
                        value: e,
                        child: Text(
                          e == 1 ? 1.toString() : 2.toString(),
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.normal),
                        ));
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.white),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  saveAllInfo();
                },
                child: const Text("Сохранить",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
