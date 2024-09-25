import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shedule_app/config.dart';
import 'package:shedule_app/pages/group_info_selected.dart';
import 'package:shedule_app/parser/parse.dart';

class ChooseGroup extends StatefulWidget {
  ChooseGroup({super.key});

  @override
  State<ChooseGroup> createState() => _ChooseGroupState();
}

class _ChooseGroupState extends State<ChooseGroup> {
  String searchText = "";
  List<String> _groups = [];
  List<String> _foundGroups = [];

  void updateSearchText(String value) {
    setState(() {
      searchText = value.toLowerCase().trim();
    });

    List<String> _temp = _groups
        .where((elem) => elem.toLowerCase().contains(searchText))
        .toList();

    setState(() {
      _foundGroups = _temp;
    });
  }

  void updateGroupShedule(String group) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GroupInfo(selectedGroup: group)));
  }

  @override
  void initState() {
    super.initState();
    fetchGroups();
  }

  Future<void> fetchGroups() async {
    List<String> groups = await fetchInstitutes();
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
              SearchAnchor(
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) => [],
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onChanged: (value) {
                      updateSearchText(value);
                    },
                    leading: const Icon(Icons.search),
                  );
                },
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
                        updateGroupShedule(_groups[index]);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15.0),
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(_foundGroups[index],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
