import 'package:flutter/material.dart';

class PaintToolbar extends StatelessWidget {
  final Color selectedColor;
  final double selectedWidth;  
  final ValueChanged<Color> onColorSelected;
  final ValueChanged<double> onWidthChanged;
  
  static const List<Color> _palette = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple
  ];

  const PaintToolbar({
    super.key,
    required this.selectedColor,
    required this.selectedWidth,
    required this.onColorSelected,
    required this.onWidthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Colors.grey[200],
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._palette.map((color) {
                      final isSelected = color == selectedColor;
                      return GestureDetector(
                        onTap: () => onColorSelected(color),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: Colors.black, width: 2)
                                : null,
                          ),
                          child: CircleAvatar(
                            backgroundColor: color,
                            radius: isSelected ? 14 : 12,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.brush, size: 18),
                    Expanded(
                      child: Slider(
                        value: selectedWidth,
                        min: 1.0,
                        max: 20.0,
                        onChanged: onWidthChanged,
                      ),
                    ),
                    Text("${selectedWidth.toStringAsFixed(1)} px"),
                  ],
                ),
              ],
            )
          ]
        )
      )
    );
  }
}