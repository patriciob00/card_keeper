import 'package:card_keeper/screens/main_page/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarBrightness: Brightness.dark, // Dark text for status bar
    ));

    return const MaterialApp(
        title: 'PokéDeck',
        debugShowCheckedModeBanner: false,
        home: MainPage());
  }
}


