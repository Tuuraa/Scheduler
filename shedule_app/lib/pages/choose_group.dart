import 'package:flutter/material.dart';

class ChooseGroup extends StatefulWidget {
  ChooseGroup({super.key});

  @override
  State<ChooseGroup> createState() => _ChooseGroupState();
}

class _ChooseGroupState extends State<ChooseGroup> {
  String searchText = "";

  void updateSearchText(String value) {
    setState(() {
      searchText = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Выбор группы")),
        body: Column(
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
                    updateSearchText(value);
                  },
                  leading: const Icon(Icons.search),
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ));
  }
}
