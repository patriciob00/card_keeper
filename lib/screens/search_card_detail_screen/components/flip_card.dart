import 'dart:math';

import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/screens/search_card_detail_screen/components/back_card_widget.dart';
import 'package:card_keeper/screens/search_card_detail_screen/components/front_card_widget.dart';
import 'package:card_keeper/screens/search_card_detail_screen/main.dart';
import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  const FlipCard(
      {super.key,
      required this.widget,
      this.currentPokemon,
      this.isAlreadyOnList = false});

  final PokemonCard? currentPokemon;

  final SearchCardDetailPage widget;

  final bool isAlreadyOnList;

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with TickerProviderStateMixin {
  late AnimationController controller;
  bool isFront = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future flipCard() async {
    isFront = !isFront;

    if (isFront) {
      await controller.forward();
    } else {
      await controller.reverse();
    }
  }

  bool isFrontImage(double angle) {
    const degrees90 = pi / 2;
    const degrees270 = 3 * pi / 2;

    return angle <= degrees90 || angle >= degrees270;
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final size = MediaQuery.of(context).size;
        final angle = controller.value * -pi;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);

        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: isFrontImage(angle.abs())
              ? FrontCardWidget(
                  onTap: () => flipCard(),
                  size: size,
                  widget: widget.widget,
                )
              : BackCardWidget(
                  currentPokemon: widget.currentPokemon,
                  isAlreadyOnList: widget.isAlreadyOnList,
                  onTap: flipCard),
        );
      });
}
