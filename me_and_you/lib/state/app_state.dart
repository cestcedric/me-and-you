import 'package:flutter/material.dart';
import 'package:me_and_you/utils/index.dart';
import 'package:me_and_you/models/dish.dart';

class AppState extends ChangeNotifier {
  bool initialized = false;
  bool dataLoaded = false;

  bool alertDisplayed = false;
  bool alertNecessary = false;

  Map<String, List<Dish>> menu = {};

  // educated guess that works out fine during the week, not shown anyway
  // is updated as soon as menu data is loaded
  DateTime validFrom = DateTime.now().subtract(
    Duration(days: DateTime.now().weekday - 1),
  );
  DateTime validTo = DateTime.now().add(
    Duration(days: 7 - DateTime.now().weekday - 1),
  );
  String location = '';

  Future update() async {
    dataLoaded = false;
    // notifyListeners();

    await fetchData();
    initialized = true;
    dataLoaded = true;

    notifyListeners();
  }

  Future fetchData() async {
    var data = await queryFirestore();

    validFrom = DateTime.parse(data['validFrom']);
    validTo = DateTime.parse(data['validTo']);
    location = data['location'];
    data['dishes'].forEach((date, dishes) => {
          menu[date] =
              dishes.map<Dish>((element) => Dish.fromJson(element)).toList()
        });
  }
}
