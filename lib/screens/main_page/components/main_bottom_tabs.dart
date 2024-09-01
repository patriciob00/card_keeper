import 'package:flutter/material.dart';

class MainBottomTabs extends StatelessWidget {
  final int currentIdx;
  final Function(int idx) onTap;

  const MainBottomTabs(
      {super.key, required this.currentIdx, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 240, 0, 0),
      currentIndex: currentIdx,
      onTap: (idx) => onTap(idx),
      items: const [
        BottomNavigationBarItem(
            label: '',
            tooltip: 'Buscar',
            activeIcon: Icon(
              Icons.search,
              color: Color.fromARGB(255, 34, 34, 36),
            ),
            icon: Icon(
              Icons.search,
              color: Colors.white,
            )),
        BottomNavigationBarItem(
            label: '',
            tooltip: 'Favoritos',
            activeIcon: Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 34, 34, 36),
            ),
            icon: Icon(
              Icons.favorite_outline,
              color: Colors.white,
            )),
      ],
    );
  }
} 