import 'package:flutter/material.dart';

class ColorPickerPalette extends StatelessWidget {
  final int selectedColor;
  final ValueChanged<int> onColorSelected;

  static const List<int> defaultColors = [
    0xFF2196F3, // Blue
    0xFF4CAF50, // Green
    0xFFFF9800, // Orange
    0xFFE91E63, // Pink
    0xFF9C27B0, // Purple
    0xFF00BCD4, // Cyan
  ];

  const ColorPickerPalette({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: defaultColors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final colorValue = defaultColors[index];
          final isSelected = selectedColor == colorValue;

          return GestureDetector(
            onTap: () => onColorSelected(colorValue),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 46 : 38,
              height: isSelected ? 46 : 38,
              decoration: BoxDecoration(
                color: Color(colorValue),
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: Colors.white, width: 3)
                    : null,
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: Color(colorValue).withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                ],
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
