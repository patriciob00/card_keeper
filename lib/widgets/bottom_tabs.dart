import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BottomTabs extends StatelessWidget {
  final int currentIdx;
  final Function(int idx) onTap;

  const BottomTabs(
      {super.key, required this.currentIdx, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      elevation: 10.0,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.white,
      indicatorColor: Colors.white,
      selectedIndex: currentIdx,
      onDestinationSelected: onTap,
      backgroundColor: Colors.black.withOpacity(0.5),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.search_sharp, color: Colors.white,), label: 'Busca', selectedIcon: Icon(Icons.search_sharp),),
        NavigationDestination(icon: Icon(Symbols.fullscreen_portrait_sharp, color: Colors.white,), label: 'Lista', selectedIcon: Icon(Symbols.fullscreen_portrait_sharp)),
        NavigationDestination(icon:  Icon( Symbols.stacks,
                        color: Colors.white, fill : 0, weight: 700, grade: 0.25, opticalSize: 48 ), label: 'Decks', selectedIcon: Icon(Symbols.stacks,
                        fill : 1, weight: 700, grade: 0.25, opticalSize: 48))
      ]);  }
}
