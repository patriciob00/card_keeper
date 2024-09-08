import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainBottomTabs extends StatelessWidget {
  final int currentIdx;
  final Function(int idx) onTap;

  const MainBottomTabs(
      {super.key, required this.currentIdx, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      currentIndex: currentIdx,
      onTap: (idx) => onTap(idx),
      items: [
        BottomNavigationBarItem(
          label: '',
          tooltip: 'Home',
          activeIcon: SvgPicture.asset(
            'assets/svg/home_icon.svg',
            width: 50,
            semanticsLabel: 'home',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(
            'assets/svg/home_icon.svg',
            width: 50,
            semanticsLabel: 'search of cards',
            colorFilter:
                const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          tooltip: 'Search',
          activeIcon: SvgPicture.asset(
            'assets/svg/search_icon.svg',
            width: 50,
            semanticsLabel: 'search of cards',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(
            'assets/svg/search_icon.svg',
            width: 50,
            semanticsLabel: 'search of cards',
            colorFilter:
                const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          tooltip: 'Lista',
          activeIcon: SvgPicture.asset(
            'assets/svg/list_cards.svg',
            width: 50,
            semanticsLabel: 'list of cards',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(
            'assets/svg/list_cards.svg',
            width: 50,
            semanticsLabel: 'list of cards',
            colorFilter:
                const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          tooltip: 'Decks',
          activeIcon: SvgPicture.asset(
            'assets/svg/deck_icon.svg',
            width: 50,
            semanticsLabel: 'card',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(
            'assets/svg/deck_icon.svg',
            width: 50,
            semanticsLabel: 'card',
            colorFilter:
                const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}
