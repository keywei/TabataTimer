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
    final scheme = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _RingPainter(
          progress: progress,
          color: color,
          trackColor: scheme.outlineVariant,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                bigText,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 120,
                      fontFeatures: const [FontFeature.tabularFigures()],
                      fontWeight: FontWeight.w200,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      letterSpacing: 1.2,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
  });

  final double progress;
  final Color color;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) / 2 - 6;
    const stroke = 2.0;

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = trackColor;
    canvas.drawCircle(center, radius, track);

    final foreground = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke
      ..color = color;

    final start = -math.pi / 2;
    final sweep = 2 * math.pi * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep,
      false,
      foreground,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.trackColor != trackColor;
}
