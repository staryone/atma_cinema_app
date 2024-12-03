import 'package:flutter/material.dart';

class ScreenArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 120),
      painter: ScreenPainter(),
      child: Center(
        child: Text(
          'Screen Area',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

class ScreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.1, 0) // Titik kiri atas melingkar
      ..quadraticBezierTo(
        size.width * 0.5, -30, // Titik kontrol untuk lengkungan
        size.width * 0.9, 0, // Titik kanan atas melingkar
      )
      ..lineTo(size.width * 0.8, size.height) // Titik kanan bawah
      ..lineTo(size.width * 0.2, size.height) // Titik kiri bawah
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
