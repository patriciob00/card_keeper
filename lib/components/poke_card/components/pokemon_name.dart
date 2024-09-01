import 'package:flutter/material.dart';

final class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    Path path = Path();

    path
      ..lineTo(size.width * .75, 0) // .85 amount of right gap
      ..lineTo(size.width * .80, size.height / 2)
      ..lineTo(size.width * .75, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PokemonName extends StatelessWidget {
  const PokemonName({Key? key, required this.name, required this.id})
      : super(key: key);
  final String name;
  final int id;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: ArrowPainter(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Row(
            children: [
              Text(
                '#$id $name',
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
