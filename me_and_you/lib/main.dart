import 'dart:ui';
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
    // async data retrieval to fill state, start as early as possible
    var appState = AppState();
    appState.update();

    return ChangeNotifierProvider(
      create: (context) => appState,
      child: MaterialApp(
        scrollBehavior: MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
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
