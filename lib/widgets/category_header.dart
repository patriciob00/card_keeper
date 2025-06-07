import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final String text;
  final double widthFraction;

  const CategoryHeader({
    super.key,
    required this.text,
    this.widthFraction = 0.75,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final barWidth = screenWidth * widthFraction;

    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: barWidth,
        height: 50,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Retângulo inferior
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: barWidth,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            // Retângulo superior com sombra
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: barWidth,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      offset: const Offset(-2, 2),
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}