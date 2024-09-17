import 'package:card_keeper/controllers/pokemon_cards_controller.dart';
import 'package:card_keeper/screens/cards_list_screen/main.dart';
import 'package:card_keeper/screens/deck_list_screen/main.dart';
import 'package:card_keeper/screens/search_screen/main.dart';
import 'package:card_keeper/widgets/bottom_tabs.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent, // Transparent status bar
    //   statusBarBrightness: Brightness.dark, // Dark text for status bar
    // ));

    return const MaterialApp(
        title: 'PokéDeck',
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: MainPage()));
  }
}

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => MainPageState();

}

class MainPageState extends ConsumerState<MainPage> {
 int currentIdx = 0;

 late PokemonCardsControler _controller;

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

 void initializeDb() async {
    await _controller.initializeCardsListFromDb();

    FlutterNativeSplash.remove();
 }

 @override
  void initState() {
    super.initState();
    _controller = PokemonCardsControler(ref: ref);

    initializeDb();
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: _setScreen(),
        bottomNavigationBar: BottomTabs(currentIdx: currentIdx, onTap: _onItemTapped),
        );
  }
}


