import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:me_and_you/widgets/config.dart';

Future<dynamic> queryFirestore() async {
  return http
      .get(getFirestorePath())
      .then((response) => response.body)
      .then((body) => json.decode(body))
      .then((body) => json.decode(body['fields']['data']['stringValue']));
}

Uri getFirestorePath() {
  return Uri.parse(
      '${Config.firestoreBaseUrl}/projects/${Config.gcloudProjectId}/databases/${Config.firestoreDbId}/documents/${Config.firestoreDocumentId}');
}

String getWeekday(DateTime date) {
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

String dateToDottedString(DateTime date) {
  return '${date.day}.${date.month}.${date.year}';
}

String dateToDashedString(DateTime date) {
  return '${date.year}-${date.month}-${date.day}';
}

String formatPrice(num price) {
  return '${price.toStringAsFixed(2)} €';
}
