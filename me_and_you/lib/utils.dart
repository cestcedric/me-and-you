import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:me_and_you/widgets/config.dart';

Future<dynamic> fetchFile(String id) async {
  return http
      .get(Uri.parse('${Config.driveBaseUrl}$id'))
      .then((response) => utf8.decode(response.bodyBytes))
      .then((data) => json.decode(data));
}

String dateToString(DateTime date) {
  return [
    'Montag',
    'Dienstag',
    'Mittwoch',
    'Donnerstag',
    'Freitag',
    'Samstag',
    'Sonntag'
  ][date.weekday - 1];
}
