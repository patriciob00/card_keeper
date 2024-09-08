import 'package:card_keeper/screens/main_page/components/main_bar.dart';
import 'package:card_keeper/screens/main_page/components/main_bottom_tabs.dart';
import 'package:card_keeper/screens/main_page/components/main_content.dart';
// import 'package:card_keeper/screens/main_page/components/main_bottom_nav.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();

}

class MainPageState extends State<MainPage> {
 int currentIdx = 1; 

 void _onItemTapped(int idx) {
  setState(() {
    if(idx == 0 || idx == 3) return;
    currentIdx = idx;
  });
 }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: MainBarWithGlass(),
        // bottomNavigationBar: BottomNav(currentIdx: currentIdx, onTap: _onItemTapped),
        bottomNavigationBar: MainBottomTabs(currentIdx: currentIdx, onTap: _onItemTapped),
        body: MainContent(currentTab: currentIdx,)
        );
  }
}
