import 'package:shared_preferences/shared_preferences.dart';
import "package:shedule_app/config.dart";

final List<String> weekdays = [
    "Понедельник",
    "Вторник",
    "Среда",
    "Четверг",
    "Пятница",
    "Суббота",
    "Воскресенье"
  ];

class SetupData {
  
  static void saveData(Map<String, Object?> map) async {
    final prefs = await SharedPreferences.getInstance();
    print(map["group"].toString());
    if (map["group"] != null) {
      prefs.setString("group", map["group"].toString());
    }
    if (map["curs"] != null) {
      prefs.setInt("curs", int.parse(map["curs"].toString()));
    }
    if (map["semester"] != null) {
      prefs.setInt("semester", int.parse(map["semester"].toString()));
    }
    if (map["inst"] != null) {
      prefs.setString("inst", map["inst"].toString());
    }
  }

  static Future<void> initData() async {
    final prefs = await SharedPreferences.getInstance();

    Config.selectedGroup = prefs.getString("group") ?? "21-КБ-ПР2";
    Config.selectedCurs = prefs.getInt("curs") ?? 4;
    Config.selectedSemester = prefs.getInt("semester") ?? 2;
    Config.selectedInst = prefs.getString("inst") ?? "Институт компьютерных систем и информационной безопасности";
    print("done");
  }

}