import 'package:flutter/material.dart';

class ReviewBar extends StatelessWidget {
  final int stars;
  final double percentage; // 0.0 to 1.0

  const ReviewBar({super.key, required this.stars, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$stars",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(width: 8),
        Icon(Icons.star, size: 12, color: Colors.amber),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[200],
              color: Colors.amber,
              minHeight: 6,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "${(percentage * 100).toInt()}%",
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }
}
