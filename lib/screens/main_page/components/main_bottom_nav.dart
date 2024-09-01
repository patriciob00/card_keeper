import 'package:card_keeper/models/nav_item_model.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {

  static Color bottomNavBgColor = Colors.white;

  final int currentIdx;
  
  final Function onTap;

  const BottomNav({ super.key, required this.currentIdx, required this.onTap });
  
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 24),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                  color: bottomNavBgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: bottomNavBgColor.withOpacity(0.2),
                      offset: const Offset(-5, 10),
                      blurRadius: 40,
                    ),
                  ]),
              child: Wrap(
                spacing: 24,
                alignment: WrapAlignment.spaceEvenly,
                children: List.generate(bottomNavItems.length, 
                (index) {
                  return GestureDetector(
                    onTap: () {
                      onTap(index);
                    },
                    child: TabItem(selectedNavItemIdx: currentIdx, index: index),
                  );
                }),
              ),
            ),
          ],
        ));
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.selectedNavItemIdx,
    required this.index,
  });

  final int index;

  final int selectedNavItemIdx;

  @override
  Widget build(BuildContext context) {
    final currentItem = bottomNavItems[index];
    final isSelected = selectedNavItemIdx == index;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        AnimatedBar(isActive: isSelected),
        SizedBox(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isSelected ? 1 : 0.5,
            child: ImageIcon(
              AssetImage(currentItem.src)
            ),
            ),
        ),
      ],
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 4),
      height: 4,
      width: isActive  ? 20 : 0,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}
