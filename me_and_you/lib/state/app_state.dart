import 'package:flutter/material.dart';
import '../utils.dart';
import '../widgets/config.dart';
import 'entities/dish.dart';

class AppState extends ChangeNotifier {
  bool dataLoaded = true;

  Map<String, List<dynamic>> menu = {};

  late DateTime validFrom;
  late DateTime validTo;
  late String location;

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
          menu[date] = dishes.map((element) => Dish.fromJson(element)).toList()
        });

    dataLoaded = true;
  }
}
