import 'package:flutter/material.dart';
import 'package:sheduler/pages/group_info_selected.dart';
import 'package:sheduler/parser/parse.dart';

class ChooseGroup extends StatefulWidget {
  final VoidCallback updateSchedulerList;
  const ChooseGroup({super.key, required this.updateSchedulerList});

  @override
  State<ChooseGroup> createState() => _ChooseGroupState();
}

class _ChooseGroupState extends State<ChooseGroup> {
  String searchText = "";
  List<String> _groups =  [];
  List<String> _foundGroups =[];

  void updateSearchText(String value) {
    setState(() {
      searchText = value.toLowerCase().trim();
    });

    List<String> temp = _groups
        .where((elem) => elem.toLowerCase().contains(searchText))
        .toList();
    setState(() {
      _foundGroups = temp;
    });
  }

  void updateGroupShedule(String group) {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true, 
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.75, 
        child: GroupInfo(
          selectedGroup: group,
          updateSchedulerList: widget.updateSchedulerList,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchGroups();
  }

  Future<void> fetchGroups() async {
    List<String> groups = await fetchInstitutes();
    groups = groups.sublist(1, groups.length - 1);
    setState(() {
      _groups = groups;
      _foundGroups = groups;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Выбор группы")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                updateSearchText(value);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Введите название группы',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 5,
                  childAspectRatio: 2,
                ),
                itemCount: _foundGroups.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      updateGroupShedule(_foundGroups[index]);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(15.0),
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        _foundGroups[index],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
