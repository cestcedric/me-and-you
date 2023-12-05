import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:me_and_you/widgets/config.dart';
import 'package:me_and_you/widgets/daily_menu.dart';
import 'package:me_and_you/widgets/dish_card.dart';
import 'package:me_and_you/widgets/home.dart';

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
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

String formatPrice(num price) {
  return NumberFormat.simpleCurrency(locale: 'de_DE').format(price);
}

String formatList(List list) {
  return list.isNotEmpty ? list.join(', ') : '-';
}

String formatNum(num? x) {
  return x != null ? NumberFormat.decimalPattern('de_DE').format(x) : '-';
}

List<int> range(int length, {int start = 0, int step = 1}) {
  return List.generate(length, (index) => start + index * step);
}

double scrollToToday(
  DateTime validFrom,
  int validityPeriod,
  double screenWidth,
  Map<String, List> items,
) {
  var today = DateTime.now().difference(validFrom).inDays;
  var contextWidth = screenWidth - DailyMenu.pad * 2;

  // don't scroll on Monday and the weekend
  if (today < 1 || today >= validityPeriod) {
    return 0.0;
  }

  final keys = items.keys.toList();
  keys.sort();

  var offset = MenuPage.appBarHeight;

  for (var i = 0; i < today; i++) {
    var itemCount = items[keys[i]]?.length ?? 0;
    var itemsPerRow = (contextWidth / DishCard.width).floor();
    var rowCount = (itemCount / itemsPerRow).ceil();

    offset += DailyMenu.headerHeight;
    offset += rowCount * DishCard.height;
    offset += DailyMenu.pad;
  }

  return offset;
}
