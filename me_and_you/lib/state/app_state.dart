import 'package:flutter/material.dart';
import 'package:me_and_you/utils.dart';
import 'package:me_and_you/widgets/config.dart';
import 'package:me_and_you/entities/dish.dart';

class AppState extends ChangeNotifier {
  bool dataLoaded = true;

  Map<String, List<Dish>> menu = {};

  // educated guess that works out fine during the week, shows last week on week-end
  // is updated as soon as menu data is loaded
  DateTime validFrom = DateTime.now().subtract(
    Duration(days: DateTime.now().weekday - 1),
  );
  DateTime validTo = DateTime.now().add(
    Duration(days: 7 - DateTime.now().weekday - 1),
  );
  String location = '';

  // Hide initial data fetching in page loading time, usually pretty quick
  Future init() async {
    await fetchData();
    notifyListeners();
  }

  Future update() async {
    dataLoaded = false;
    notifyListeners();

    await fetchData();

    notifyListeners();
  }

  Future fetchData() async {
    var data = await fetchFile(Config.menu);

    validFrom = DateTime.parse(data['validFrom']);
    validTo = DateTime.parse(data['validTo']);
    location = data['location'];
    data['dishes'].forEach((date, dishes) => {
          menu[date] =
              dishes.map<Dish>((element) => Dish.fromJson(element)).toList()
        });

    dataLoaded = true;
  }
}
