import 'package:card_keeper/screens/main_page/components/tabs/main_tab_list_all.dart';
import 'package:card_keeper/screens/main_page/components/tabs/main_tab_search/main.dart';
import 'package:flutter/material.dart';

class MainContent extends StatelessWidget {
  final int currentTab;

  const MainContent({ super.key, required this.currentTab });

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  static const List<Widget> _tabOptions = <Widget>[
  MainTabListAll(),
  MainTabSearch(),
  ];

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 0, 0, 0),
        image: DecorationImage(
          opacity: 0.3,
          scale: 1.5,
          image: AssetImage('assets/images/pokeball.png'),
        ),
      ),
      child: _tabOptions.elementAt(currentTab),
    );
  }
}
