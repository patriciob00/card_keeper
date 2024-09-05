import 'package:card_keeper/screens/main_page/components/main_bar.dart';
import 'package:flutter/material.dart';

class MainTabListAll extends StatelessWidget {
  const MainTabListAll({ super.key });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(top: MainBarWithGlass().preferredSize.height + 60.0),
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 2 / 3,
      children: List.generate(10, (index) => Container()),
    );
  }
}