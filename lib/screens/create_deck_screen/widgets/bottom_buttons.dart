// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BottomButtons extends StatelessWidget {
  final PageController pageController;
  final double pages;
  final double currentPage;
  final bool? disabledNext;

  const BottomButtons(
      {super.key, required this.pageController, required this.pages, required this.currentPage, this.disabledNext});

  @override
  Widget build(BuildContext context) {
    final bool isFirstScreen = currentPage == 0;
    final bool isLastScreen = currentPage == pages -1;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              isFirstScreen
                  ? null
                  : pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
            },
            style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.black.withOpacity(0.3),
                disabledForegroundColor:
                    Colors.deepPurpleAccent.withOpacity(0.3),
                backgroundColor: isFirstScreen ? Colors.black.withOpacity(0.3) : Colors.deepPurpleAccent,
                foregroundColor: isFirstScreen ? Colors.deepPurpleAccent.withOpacity(0.3) : Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: const CircleBorder(
                    side: BorderSide(
                  color: Colors.deepPurpleAccent,
                ))),
            child: Container(
              width: 50,
              height: 50,
              child: Icon(
                Icons.arrow_back,
                color: isFirstScreen ? Colors.deepPurpleAccent : Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
            disabledNext! ? null :
              pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
            },
            style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.black.withOpacity(0.3),
                disabledForegroundColor:
                    Colors.deepPurpleAccent.withOpacity(0.3),
                backgroundColor: disabledNext! ? Colors.black.withOpacity(0.3) : Colors.deepPurpleAccent,
                foregroundColor: disabledNext! ? Colors.deepPurpleAccent.withOpacity(0.3) : Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: const CircleBorder(
                  side: BorderSide(
                    color: Colors.deepPurpleAccent,
                  )  
                )),
            child: Container(
              width: 50,
              height: 50,
              child: Icon(
                isLastScreen ? Symbols.save : Icons.arrow_forward,
                color: disabledNext! ? Colors.deepPurpleAccent : Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
