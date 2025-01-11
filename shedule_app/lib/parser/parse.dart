import 'dart:convert';
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
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  final response = await httpClient
      .getUrl(Uri.parse(url))
      .then((request) => request.close());

  if (response.statusCode == 200) {
    var responseBody = await utf8.decodeStream(response);
    var document = parse(responseBody);
    print(document);
    List<String> groups = document
        .getElementsByTagName('option')
        .skip(20)
        .map((element) => element.text)
        .toList();
    return groups;
  } else {
    throw Exception('Failed to load institutes');
  }
}
