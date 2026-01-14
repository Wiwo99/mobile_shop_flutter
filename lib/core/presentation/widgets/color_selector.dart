import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<int> colors;
  final int selectedIndex;
  final Function(int) onSelect;

  const ColorSelector({
    super.key,
    required this.colors,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(colors.length, (index) {
        final isSelected = selectedIndex == index;
        return GestureDetector(
          onTap: () => onSelect(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(right: 12),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Color(colors[index]),
              border: Border.all(
                color: isSelected ? Colors.black : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(8), // Square-ish look
            ),
            child: isSelected
                ? Center(
                    child: Icon(Icons.check, color: Colors.white, size: 20),
                  )
                : null,
          ),
        );
      }),
    );
  }
}
