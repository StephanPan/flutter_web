import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';

class SigaturePainter extends CustomPainter{
  SigaturePainter(this.points, );
  final List<Offset> points;
  void paint(Canvas canvas, Size size){
    Rect rect = Offset.zero & Size(512,512);
    canvas.clipRect(rect);
   
    Paint paint = new Paint()
      ..color = Color.fromRGBO(100,188,252,0.25)
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 16.0
      ..strokeJoin = StrokeJoin.round;
    for (int i = 0; i < points.length-1;i++){
      if (points[i].dx>=0 && points[i].dy>=0 && points[i+1].dx >= 0 && points[i+1].dy >=0){
        canvas.drawLine(points[i], points[i+1], paint);
      }
    }
  }
  // 是否重新绘制
  bool shouldRepaint(SigaturePainter other) => other.points != points;
}