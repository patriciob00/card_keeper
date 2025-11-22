import 'package:flutter/material.dart';

class BadgeCustom extends StatelessWidget {
  const BadgeCustom({
    super.key,
    this.backgroundColor = Colors.white,
    required this.child,
  });

  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 16,
      height: 16,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: child,
    );
  }
}