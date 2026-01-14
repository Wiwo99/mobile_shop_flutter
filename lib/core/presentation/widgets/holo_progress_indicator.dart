import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A custom-painted progress indicator with a holographic/liquid effect.
class HoloProgressIndicator extends StatefulWidget {
  final double size;
  final Color? color;

  const HoloProgressIndicator({super.key, this.size = 60, this.color});

  @override
  State<HoloProgressIndicator> createState() => _HoloProgressIndicatorState();
}

class _HoloProgressIndicatorState extends State<HoloProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.color ?? Theme.of(context).primaryColor;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _HoloPainter(color: themeColor, progress: _controller.value),
        );
      },
    );
  }
}

class _HoloPainter extends CustomPainter {
  final Color color;
  final double progress;

  _HoloPainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 1. Draw Outer Ring
    final ringPaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, ringPaint);

    // 2. Draw Rotating Arcs (Holographic feel)
    final arcPaint = Paint()
      ..shader = SweepGradient(
        colors: [color.withValues(alpha: 0), color, color.withValues(alpha: 0)],
        stops: const [0.0, 0.5, 1.0],
        transform: GradientRotation(progress * math.pi * 2),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      math.pi * 0.8,
      false,
      arcPaint,
    );

    // 3. Inner Liquid Core
    final coreRadius =
        radius * 0.4 * (1 + math.sin(progress * math.pi * 2) * 0.1);
    final corePaint = Paint()
      ..color = color
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawCircle(center, coreRadius, corePaint);
  }

  @override
  bool shouldRepaint(covariant _HoloPainter oldDelegate) => true;
}
