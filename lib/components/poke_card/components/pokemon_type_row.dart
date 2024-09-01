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
      ..moveTo(25, size.height * 0.5)
      ..lineTo(size.width * .23, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * .23, size.height)
      ..lineTo(25, size.height * .5)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PokemonTypeRow extends StatelessWidget {
  const PokemonTypeRow({Key? key, required this.name, required this.id})
      : super(key: key);
  final String name;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width / 20,
                child: Image.asset(
                  'assets/images/types_badge/fire.png',
                  fit: BoxFit.contain,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width / 20,
                child: Image.asset(
                  'assets/images/types_badge/flying.png',
                  fit: BoxFit.contain,
                )),
          ),
        ],
      ),
    );
  }
}


// return CustomPaint(
//         painter: ArrowPainter(),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               SizedBox(
//                   width: MediaQuery.of(context).size.width / 20,
//                   child: Image.asset(
//                     'assets/images/types_badge/fire.png',
//                     fit: BoxFit.contain,
//                   )),
//                   SizedBox(
//                   width: MediaQuery.of(context).size.width / 20,
//                   child: Image.asset(
//                     'assets/images/types_badge/flying.png',
//                     fit: BoxFit.contain,
//                   ))
//             ],
//           ),
//         ));
