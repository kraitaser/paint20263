import 'package:flutter/material.dart';

class PaintToolbar extends StatelessWidget {
  final double selectedRed;
  final double selectedGreen;
  final double selectedBlue;
  final Color selectedColor;
  final double selectedWidth;
  final ValueChanged<Color> onColorSelected;
  final ValueChanged<double> onWidthSelected;
  final ValueChanged<double> onRedSelected;
  final ValueChanged<double> onGreenSelected;
  final ValueChanged<double> onBlueSelected;

  static const List<Color> _palette = [
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.white,
  ];
  const PaintToolbar({
    super.key,
    required this.selectedRed,
    required this.selectedGreen,
    required this.selectedBlue,
    required this.selectedColor,
    required this.selectedWidth,
    required this.onRedSelected,
    required this.onGreenSelected,
    required this.onBlueSelected,
    required this.onColorSelected,
    required this.onWidthSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: selectedColor.withAlpha(200), // Color de fondo con transparencia
      child: SafeArea(
        //para que no se superponga con la barra de estado
        child: Column(
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
                OutlinedButton(
                  onPressed: () => _dialogBuilder(context),
                  child: const Text('picker'),
                ),
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
                    max: 35.0,
                    onChanged: onWidthSelected, 
                  ),
                ),
                Text("${selectedWidth.toStringAsFixed(1)} px"),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('seleccion de color'),
          content: Column(
              children:[
                Slider(
                    
                    value: selectedRed,
                    min: 0.0,
                    max: 255.0,
                    onChanged: onRedSelected, 
                  ),
                  Slider(
                    
                    value: selectedGreen,
                    min: 0.0,
                    max: 255.0,
                    onChanged: onGreenSelected, 
                  ),
                  Slider(
                    
                    value: selectedBlue,
                    min: 0.0,
                    max: 255.0,
                    onChanged: onBlueSelected, 
                  ),
                  
                
                Text("${selectedRed.toStringAsFixed(1)} R"),
                Text("${selectedGreen.toStringAsFixed(1)} G"),
                Text("${selectedBlue.toStringAsFixed(1)} B"),
              ]
            ),
            // Column(
            //   children:[
            //     const Icon(Icons.brush, size: 18),
            //     Expanded(
            //       child: Slider(
            //         value: selectedWidth,
            //         min: 0.0,
            //         max: 255.0,
            //         onChanged: onWidthSelected, 
            //       ),
            //     ),
            //     Text("${selectedWidth.toStringAsFixed(1)} G"),
            //   ]
            // ),
            // Column(
            //   children:[
            //     const Icon(Icons.brush, size: 18),
            //     Expanded(
            //       child: Slider(
            //         value: selectedWidth,
            //         min: 0.0,
            //         max: 255.0,
            //         onChanged: onWidthSelected, 
            //       ),
            //     ),
            //     Text("${selectedWidth.toStringAsFixed(1)} B"),
            //   ]
            // ),
          actions: <Widget>[
            
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('seleccionar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}