import 'dart:math' as math;
import 'package:flutter/material.dart';

class ReverseHoloEffect extends StatefulWidget {
  const ReverseHoloEffect({super.key});

  @override
  State<ReverseHoloEffect> createState() => _ReverseHoloEffectState();
}

class _ReverseHoloEffectState extends State<ReverseHoloEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(
        vsync: this,
        duration: const Duration(seconds: 5),
      )..repeat(); // loop contínuo

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          final angle = _controller.value * 2 * math.pi;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              // gradiente circular girando
              gradient: SweepGradient(
                center: Alignment.center,
                transform: GradientRotation(angle),
                colors: [
                  Colors.orange.withValues(alpha: .38),
                  Colors.yellow.withValues(alpha: .48),
                  Colors.red.withValues(alpha: .38),
                  Colors.transparent,
                  Colors.orange.withValues(alpha: .38),
                ],
                stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
              ),
            ),
          );
        },
      ),
    );
  }
}