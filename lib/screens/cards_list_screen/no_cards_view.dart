import 'package:flutter/material.dart';

class NoCardsView extends StatelessWidget {
  const NoCardsView({
    super.key,
    required this.emptyTextHelper,
    required this.emptySubtextHelper,
  });

  final String emptyTextHelper;
  final String emptySubtextHelper;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/pokeballs.png'),
            Text(
              emptyTextHelper,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              emptySubtextHelper,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ));
  }
}
