import 'package:flutter/material.dart';

class DrawnLine {
  final List<Offset> points; //lista de puntos que forman la línea
  final Color color;
  final double strokeWidth; //ancho de la línea

  DrawnLine({
    required this.points,
    required this.color,
    required this.strokeWidth,
  });
}