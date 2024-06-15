import 'dart:io';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;
import 'package:http/http.dart' as http;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<List<String>> fetchInstitutes() async {
  const String url =
      'https://elkaf.kubstu.ru/timetable/default/time-table-student-ofo?';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var document = parse(response.body);
    List<String> _groups = document
        .getElementsByTagName('option')
        .skip(20)
        .map((element) => element.text)
        .toList();
    return _groups;
  } else {
    throw Exception('Failed to load institutes');
  }
}
