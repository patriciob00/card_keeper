import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HoloEffect extends StatelessWidget {
  const HoloEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.transparent,
        highlightColor: Colors.white70,
        period: const Duration(milliseconds: 2500),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(8),
          ),
        ));
  }
}
