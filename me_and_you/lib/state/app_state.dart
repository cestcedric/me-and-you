import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:me_and_you/state/entities/allergen.dart';
import 'package:me_and_you/state/config.dart';

class AppState extends ChangeNotifier {
  final Map<dynamic, Allergen> allergens = {};
  var categories = {};
  var dishes = {};

  Future fetchData() async {
    print('Fetching data');

    Iterable allergenList = await fetchFile(Config.allergens);
    for (var entry in allergenList) {
      var allergen = Allergen.fromJson(entry);
      allergens[allergen.id] = allergen;
    }

    print('Allergens fetched (${allergens.length})');

    notifyListeners();
    return;
  }
}

Future<dynamic> fetchFile(String id) async {
  return http
      .get(Uri.parse('${Config.driveBaseUrl}$id'))
      .then((response) => response.body)
      .then((data) => json.decode(data));
}
