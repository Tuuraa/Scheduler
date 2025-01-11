class Config {
  static const String url =
      'https://elkaf.kubstu.ru/timetable/default/time-table-student-ofo?';

  static String? selectedGroup;
  static int? selectedCurs;
  static int? selectedSemester;
  static String? selectedInst;

  static int cursCount = 6;
  static const List<Map<int, String>> institutes = [
    {495: "Институт нефти, газа и энергетики"},
    {516: "Институт компьютерных систем и информационной безопасности"},
    {490: "Институт пищевой и перерабатывающей промышленности"},
    {29: "Институт экономики, управления и бизнеса"},
    {538: "Институт строительства и транспортной инфраструктуры"},
    {
      539:
          "Институт механики, робототехники, инженерии транспортных и технических систем"
    },
    {540: "Институт фундаментальных наук"},
    {541: "Инженерно-технологический колледж"},
    {34: "Подготовительное отделение для иностранных граждан"},
    {50: "Новороссийский политехнический институт"},
    {52: "Армавирский механико-технологический институт"}
  ];

  static int? getKeyByValueInList(String? value) {
  for (var map in institutes) {
    if (map.containsValue(value)) {
      return map.entries.firstWhere((entry) => entry.value == value).key;
    }
  }
  return null;
}
}
