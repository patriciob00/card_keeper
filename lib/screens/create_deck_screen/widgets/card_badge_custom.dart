import 'package:flutter/material.dart';

class CardBadgeCustom extends StatelessWidget {
  final Widget child;

  const CardBadgeCustom({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            offset: Offset(1, 1),
          )
        ],
      ),
      child: child,
    );
  }
}