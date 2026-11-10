import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/drawn_line.dart';

class PaintCanvasWidget extends StatelessWidget {
  final List<DrawnLine> lines;
  final Function(Offset) onPanStart;
  final Function(Offset) onPanUpdate;

  const PaintCanvasWidget({
    super.key,
    required this.lines,
    required this.onPanStart,
    required this.onPanUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onPanStart: (details) => onPanStart(details.localPosition),
        onPanUpdate: (details) => onPanUpdate(details.localPosition),
        child: CustomPaint(
          painter: _PaintPainter(lines: lines),
          size: Size.infinite,
        ),
      ),
    );
  }
}
class _PaintPainter extends CustomPainter {
  final List<DrawnLine> lines;
  
  _PaintPainter({required this.lines});
  
  @override
  void paint(Canvas canvas, Size size){
    for( final line in lines){
      if(line.points.isEmpty) continue;

      final paint = Paint()
        ..color = line.color
        ..strokeWidth = line.strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

        if(line.points.length == 1){
          canvas.drawPoints(PointMode.points, line.points ,paint);
        } else {
          for(int i =0; i < line.points.length -1; i++){
            canvas.drawLine(line.points[i], line.points[i+1], paint);
          }
        }
    }
  }
  @override
  bool shouldRepaint(covariant _PaintPainter oldDelegate) => true;
}