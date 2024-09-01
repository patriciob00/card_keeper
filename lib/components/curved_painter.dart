import 'package:flutter/material.dart';

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white.withOpacity(0.1);
    paint.style = PaintingStyle.fill; // Change this to fill
    paint.strokeWidth = size.width * 0.00;
    paint.strokeCap = StrokeCap.butt;
    paint.strokeJoin = StrokeJoin.miter;

    var path = Path();

    path.moveTo(size.width*0.0012000,size.height*0.8473429);
    path.quadraticBezierTo(size.width*0.6733333,size.height*0.6075429,size.width*0.5764667,size.height*0.4775286);
    path.cubicTo(size.width*0.4460000,size.height*0.3473571,size.width*0.5196667,size.height*0.3222000,size.width*0.6156000,size.height*0.2714286);
    path.quadraticBezierTo(size.width*0.8172333,size.height*0.1674857,size.width*1.0066667,size.height*0.0828571);
    path.lineTo(size.width*1.0166667,size.height*0.0642857);
    path.quadraticBezierTo(size.width*0.7929333,size.height*0.1564429,size.width*0.4429667,size.height*0.3132857);
    path.cubicTo(size.width*0.3685667,size.height*0.3331286,size.width*0.4984333,size.height*0.4929429,size.width*0.4989333,size.height*0.5285714);
    path.quadraticBezierTo(size.width*0.5181333,size.height*0.5704857,size.width*-0.0005333,size.height*0.8318429);

    Paint paintStroke = Paint();
      paintStroke.color = const Color.fromARGB(255, 33, 150, 243);
      paintStroke.style = PaintingStyle.stroke;
      paintStroke.strokeWidth = size.width * 0.00;
      paintStroke.strokeCap = StrokeCap.butt;
      paintStroke.strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}