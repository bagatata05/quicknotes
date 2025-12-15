import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  const ColorPicker({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: noteColors
                .map((color) => _buildColorChoice(context, color))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildColorChoice(BuildContext context, Color color) {
    bool isSelected = selectedColor.value == color.value;
    return GestureDetector(
      onTap: () => onColorSelected(color),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                )
              : null,
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
          ],
        ),
        width: 40,
        height: 40,
      ),
    );
  }
}

final List<Color> noteColors = [
  const Color(0xFFFFCBE1),
  const Color(0xFFD6E5BD),
  const Color(0xFFF9E1A8),
  const Color(0xFFBCD8EC),
  const Color(0xFFDCCCEC),
  const Color(0xFFFFDAB4),
];