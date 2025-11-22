import 'package:flutter/material.dart';

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({
    required this.builder,
    this.barrierLabel,
    this.barrierColor = const Color(0xB3000000), // preto com alpha ~70%
    this.duration = const Duration(milliseconds: 250),
  });

  final WidgetBuilder builder;
  @override
  final String? barrierLabel;
  @override
  final Color barrierColor;
  final Duration duration;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => duration;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }
}