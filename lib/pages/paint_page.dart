import 'package:flutter/material.dart';
import 'package:paint20263/models/drawn_line.dart';
import 'package:paint20263/widgets/paint_canvas.dart';
import 'package:paint20263/widgets/paint_toolbar.dart';

class PaintPage extends StatefulWidget {
  const PaintPage({super.key});

  @override
  State<PaintPage> createState() => _PaintPageState();
}
class _PaintPageState extends State<PaintPage> {
  List<DrawnLine> _lines = [];
  Color selectedColor = Colors.black;
  double selectedWidth = 5.0;

  void _onPanStart(Offset position){
    setState(() {
      _lines.add(DrawnLine(points:[position], color: selectedColor, strokeWidth: selectedWidth));
    });
  }
  void _onPanUpdate(Offset position){
    setState(() {
      if(_lines.isNotEmpty){
        _lines.last.points.add(position);
      }
    });
  }
  void _clearCanvas(){
    setState(() {
      _lines.clear();
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 
          const Text('Paint'),
          foregroundColor: Color.lerp(selectedColor, Colors.white, .9), // Color del texto con transparencia
        backgroundColor: selectedColor.withAlpha( 200), // Color de fondo con transparencia
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'limpiar lienzo',
            onPressed: _clearCanvas,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PaintCanvasWidget(
              lines: _lines,
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate
            ),
          ),
          PaintToolbar(
            selectedColor: selectedColor,
            selectedWidth: selectedWidth,
            selectedRed: selectedColor.red.toDouble(),
            selectedGreen: selectedColor.green.toDouble(),  
            selectedBlue: selectedColor.blue.toDouble(),
            onColorSelected: (color) {
              setState(() {
                selectedColor = color;
              });
            },
            onWidthSelected: (width) {
              setState(() {
                selectedWidth = width;
              });
            },
            onRedSelected: (red) {
              setState(() {
                selectedColor = selectedColor.withRed(red.toInt());
              });
            },
            onGreenSelected: (green) {
              setState(() {
                selectedColor = selectedColor.withGreen(green.toInt());
              });
            },
            onBlueSelected: (blue) {
              setState(() {
                selectedColor = selectedColor.withBlue(blue.toInt());
              });
            },
          )
        ],
      )
    );
  } 
}