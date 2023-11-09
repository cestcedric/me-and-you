import 'package:flutter/material.dart';
import '../utils.dart';
import '../widgets/config.dart';
import 'entities/dish.dart';

class AppState extends ChangeNotifier {
  bool dataLoaded = false;

  Map<String, List<dynamic>> menu = {};

  late DateTime validFrom;
  late DateTime validTo;
  late String location;

  static Future<AppState> getAppState() async {
    var appState = AppState();
    await appState.fetchData();
    return appState;
  }

  Future fetchData() async {
    dataLoaded = false;
    notifyListeners();

    var data = await fetchFile(Config.menu);

    validFrom = DateTime.parse(data['validFrom']);
    validTo = DateTime.parse(data['validTo']);
    location = data['location'];
    data['dishes'].forEach((date, dishes) => {
          menu[date] = dishes.map((element) => Dish.fromJson(element)).toList()
        });

    dataLoaded = true;

    notifyListeners();
    return;
  }
}
