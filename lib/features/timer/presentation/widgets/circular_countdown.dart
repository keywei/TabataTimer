import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircularCountdown extends StatelessWidget {
  const CircularCountdown({
    super.key,
    required this.progress,
    required this.color,
    required this.label,
    required this.bigText,
    required this.subtitle,
  });

  final double progress;
  final Color color;
  final String label;
  final String bigText;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _RingPainter(progress: progress, color: color),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: color,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                bigText,
                style: const TextStyle(
                  fontSize: 96,
                  fontWeight: FontWeight.w800,
                  fontFeatures: [FontFeature.tabularFigures()],
                  height: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) / 2 - 12;

    final bg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..color = color.withValues(alpha: 0.15);
    canvas.drawCircle(center, radius, bg);

    final fg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16
      ..color = color;

    final start = -math.pi / 2;
    final sweep = 2 * math.pi * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep,
      false,
      fg,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress || old.color != color;
}
