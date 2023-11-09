import 'package:flutter/material.dart';
import 'package:me_and_you/state/app_state.dart';
import 'package:me_and_you/widgets/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(CanteenApp());
}

class CanteenApp extends StatelessWidget {
  const CanteenApp({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = AppState();
    appState.init();

    return ChangeNotifierProvider(
      create: (context) => appState,
      child: MaterialApp(
        title: 'Me & You',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue, brightness: Brightness.light)),
        darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue, brightness: Brightness.dark)),
        home: MenuPage(),
      ),
    );
  }
}
