import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A high-performance custom painter for product cards.
/// demonstrating Lead Architect level control over the rendering pipeline.
class ProductCardPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final double animationValue;

  ProductCardPainter({
    required this.primaryColor,
    required this.secondaryColor,
    this.animationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final RRect rRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(16),
    );

    // 1. Draw Main Gradient Background
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          primaryColor.withValues(alpha: 0.8),
          secondaryColor.withValues(alpha: 0.4),
        ],
      ).createShader(rect);

    canvas.drawRRect(rRect, paint);

    // 2. Add Organic Geometric Patterns (Lead Architect technique for "Life" in UI)
    _drawCircles(canvas, size);
    _drawOrganicLines(canvas, size);

    // 3. Inner Glow/Border for Glassmorphism effect
    final borderPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.5),
          Colors.transparent,
          Colors.white.withValues(alpha: 0.1),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRRect(rRect, borderPaint);
  }

  void _drawCircles(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.05);

    // Subtle background circle 1
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.2),
      size.width * 0.3,
      paint,
    );

    // Subtle background circle 2 (animated)
    final animatedOffset = math.sin(animationValue * math.pi * 2) * 10;
    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.8 + animatedOffset),
      size.width * 0.15,
      paint,
    );
  }

  void _drawOrganicLines(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.6,
      size.width,
      size.height * 0.8,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ProductCardPainter oldDelegate) {
    return oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.animationValue != animationValue;
  }
}
