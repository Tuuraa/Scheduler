class Config {
  static const String url =
      'https://elkaf.kubstu.ru/timetable/default/time-table-student-ofo?';

  static String selectedGroup = "21-КБ-ПР2";
  static int selectedCurs = 3;
  static String? selectedInst =
      "Институт компьютерных систем и информационной безопасности";
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

  static String getFullUrl() {
    String _tempUrl =
        'https://elkaf.kubstu.ru/timetable/default/time-table-student-ofo?isk' +
            'iosk=0&fak_id=516&kurs=${selectedGroup.split("-")[0][1]}&gr=' +
            '&ugod=2023&semestr=2';

    return "";
  }
}
