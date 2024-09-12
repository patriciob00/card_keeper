import 'package:card_keeper/screens/cards_list_screen.dart';
import 'package:card_keeper/screens/deck_list_screen/main.dart';
import 'package:card_keeper/screens/search_screen/main.dart';
import 'package:card_keeper/widgets/bottom_tabs.dart';
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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();

}

class MainPageState extends State<MainPage> {
 int currentIdx = 0; 

 void _onItemTapped(int idx) {
  setState(() {
    currentIdx = idx;
  });
 }

 Widget _setScreen() {
  switch(currentIdx) {
    case 0:
      return SearchScreen(currentIdx: currentIdx, onTap: _onItemTapped,);
    case 1:
      return CardListScreen(currentIdx: currentIdx, onTap: _onItemTapped,);
    case 2:
      return DeckListScreen(currentIdx: currentIdx, onTap: _onItemTapped,);

    default:
      return SearchScreen(currentIdx: currentIdx, onTap: _onItemTapped,);
  }
 }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: _setScreen(),
        bottomNavigationBar: BottomTabs(currentIdx: currentIdx, onTap: _onItemTapped),
        );
  }
}


