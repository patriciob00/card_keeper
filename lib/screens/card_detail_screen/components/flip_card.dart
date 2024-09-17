import 'dart:math';

import 'package:card_keeper/screens/card_detail_screen/components/card_widget.dart';
import 'package:card_keeper/screens/card_detail_screen/main.dart';
import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  const FlipCard({super.key, required this.widget});

  final SearchCardDetailPage widget;

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
              ? CardWidget(
                  onTap: () => flipCard(),
                  size: size,
                  widget: widget.widget,
                )
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(pi),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          width: size.width * 0.90,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Image.asset(
                            'assets/images/card-back.png',
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.contain,
                          )),
                      Positioned(
                        child: Container(
                          width: size.width * 0.82,
                          height: size.height * 0.525,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black.withOpacity(0.5)),
                        ),
                      ),
                      Positioned.fill(
                          child: Material(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              color: Colors.transparent,
                              child: InkWell(
                                  splashColor: Colors.white24,
                                  onTap: () => flipCard()))),
                    ],
                  ),
                ),
        );
      });
}
