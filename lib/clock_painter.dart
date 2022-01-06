import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ClockPainter extends CustomPainter {
  final int second;
  final int minute;
  final int hour;
  final bool isAM;
  final TextPainter _hourTextPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr
  );

  ClockPainter({required this.second, required this.minute, required this.hour, required this.isAM});
  @override
  void paint(Canvas canvas, Size size) {

    var angle = vector.radians(-90);

    final double r = sqrt(size.width * size.width + size.height * size.height) / 2;
    final alpha = atan(size.height/size.width);
    final beta = alpha + angle;
    final shiftY = r * sin(beta);
    final shiftX = r * cos(beta);
    final translateX = size.width / 2 - shiftX;
    final translateY = size.height / 2 - shiftY;
    canvas.translate(translateX, translateY);
    canvas.rotate(angle);

    var center = Offset(size.width/2, size.height/2);
    final paint = Paint();
    paint.color = Colors.black;
    canvas.drawCircle(center, (size.width/4) - 5, paint);
    paint.strokeCap = StrokeCap.round;


    double secondDegree = 360 / 60 * second;
    double minuteDegree = 360 / 60 * minute;
    double hourseDegree = (hour < 12) ? 360/12 * hour : 360 / 12 * (hour - 12);

    for(int i = 0; i<60;i++){

      // clock circle
      double degree = 360 / 60 * i;

      paint.color = Colors.black;
      paint.strokeWidth = (i % 5 == 0)?6:4;

      int distance =  (i % 5 == 0)?13:18;

      double x1 = (size.width / 2) + (size.width / 4 + distance) * cos(vector.radians(degree));
      double y1 = (size.height / 2) + (size.width / 4 + distance) * sin(vector.radians(degree));
      final p1 = Offset(x1, y1);

      double x2 = (size.width / 2) + (size.width / 4 + 30) * cos(vector.radians(degree));
      double y2 = (size.height / 2) + (size.width / 4 + 30) * sin(vector.radians(degree));
      final p2 = Offset(x2, y2);

      canvas.drawLine(p1, p2, paint);
    }

    for(int i = 0; i<60;i++){

      // Minute Hand
      double degree = 360 / 60 * i;

      paint.color = (i*6 == minuteDegree) ? Color(0xffffdd00) : Colors.transparent;
      paint.strokeWidth = (i % 5 == 0)?7:5;

      int distance =  (i % 5 == 0)?13:18;

      double x1 = (size.width / 2) + (size.width / 4 + distance) * cos(vector.radians(degree));
      double y1 = (size.height / 2) + (size.width / 4 + distance) * sin(vector.radians(degree));
      final p1 = Offset(x1, y1);

      double x2 = (size.width / 2) + (size.width / 4 + 30) * cos(vector.radians(degree));
      double y2 = (size.height / 2) + (size.width / 4 + 30) * sin(vector.radians(degree));
      final p2 = Offset(x2, y2);

      canvas.drawLine(p1, p2, paint);
    }

    for(int i = 0; i<12;i++){

      // Hour Hand
      double degree = 360 / 12 * i;

      paint.color = (i*30 == hourseDegree) ? Color(0xFF0031EC) : Colors.transparent;
      paint.strokeWidth = 7;

      int distance =  13;

      double x1 = (size.width / 2) + (size.width / 4 + distance) * cos(vector.radians(degree));
      double y1 = (size.height / 2) + (size.width / 4 + distance) * sin(vector.radians(degree));
      final p1 = Offset(x1, y1);

      double x2 = (size.width / 2) + (size.width / 4 + 30) * cos(vector.radians(degree));
      double y2 = (size.height / 2) + (size.width / 4 + 30) * sin(vector.radians(degree));
      final p2 = Offset(x2, y2);

      canvas.drawLine(p1, p2, paint);
    }

    for(int i = 0; i<60;i++){

      // Seconds Hand
      double degree = 360 / 60 * i;

      paint.color = (i*6 <= secondDegree)?Color(0xFFE21B1B):Colors.transparent;
      paint.strokeWidth = (i % 5 == 0)?7:5;

      int distance =  15;
      double rad = (i % 5 == 0) ? 3 : 2;

      double x1 = (size.width / 2) + (size.width / 5 + distance) * cos(vector.radians(degree));
      double y1 = (size.height / 2) + (size.width / 5 + distance) * sin(vector.radians(degree));
      final p1 = Offset(x1, y1);

      canvas.drawCircle(p1, rad, paint);
    }

    for(int i = 0; i<12; i++) {
      double degree = 360 / 12 * i;
      paint.color = (i*30 == hourseDegree && hourseDegree == minuteDegree) ? Color(
          0xFF32BB00) : Colors.transparent;

      int distance =  13;
      paint.strokeWidth = (i % 5 == 0)?7:5;

      double x1 = (size.width / 2) + (size.width / 4 + distance) * cos(vector.radians(degree));
      double y1 = (size.height / 2) + (size.width / 4 + distance) * sin(vector.radians(degree));
      final p1 = Offset(x1, y1);

      double x2 = (size.width / 2) + (size.width / 4 + 30) * cos(vector.radians(degree));
      double y2 = (size.height / 2) + (size.width / 4 + 30) * sin(vector.radians(degree));
      final p2 = Offset(x2, y2);

      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}