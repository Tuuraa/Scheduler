import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sheduler/config.dart';
import 'package:sheduler/utils/setup.dart';

class GroupInfo extends StatefulWidget {
  String selectedGroup;
  final VoidCallback updateSchedulerList;

  GroupInfo({super.key, required this.selectedGroup, required this.updateSchedulerList});
  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  List<String> _institutes = [];
  String? selectedInst;
  int selectedCurs = 1;
  int selectedSemester = 1; 

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
    Config.selectedSemester = selectedSemester; 

    SetupData.saveData({
      "group": widget.selectedGroup,
      "curs": selectedCurs,
      "inst": selectedInst,
      "semester": selectedSemester, 
    });

    widget.updateSchedulerList();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Доп. информация"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Выберите институт",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButtonHideUnderline(
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
                          child: Text(
                            e,
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Выберите курс",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButtonHideUnderline(
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
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Выберите семестр",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButtonHideUnderline(
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
                            e == 1 ? "1" : "2",
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      saveAllInfo();
                    },
                    child: const Text(
                      "Сохранить",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
