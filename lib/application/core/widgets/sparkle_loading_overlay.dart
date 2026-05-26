import 'dart:math';

import 'package:flutter/material.dart';

class SparkleLoadingOverlay extends StatelessWidget {
  const SparkleLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.55),
        child: const Center(child: _SparkleLoader()),
      ),
    );
  }
}

class _SparkleLoader extends StatefulWidget {
  const _SparkleLoader();

  @override
  State<_SparkleLoader> createState() => _SparkleLoaderState();
}

class _SparkleLoaderState extends State<_SparkleLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => CustomPaint(
        size: const Size(110, 100),
        painter: _SparklePainter(_controller.value),
      ),
    );
  }
}

class _SparklePainter extends CustomPainter {
  const _SparklePainter(this.t);
  final double t;

  // Draws a 4-pointed star with very sharp elongated tips + soft glow
  void _drawStar(Canvas canvas, Offset center, double radius, double opacity) {
    if (opacity <= 0) return;

    final path = _starPath(center, radius);

    // Soft glow layer
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white.withValues(alpha: opacity * 0.35)
        ..style = PaintingStyle.fill
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, radius * 0.6),
    );

    // Solid white fill
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white.withValues(alpha: opacity)
        ..style = PaintingStyle.fill,
    );
  }

  // 4-pointed sparkle: inner radius is only 6% of outer → very sharp tips
  Path _starPath(Offset center, double outer) {
    final inner = outer * 0.06;
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final angle = (i * pi / 4) - pi / 2;
      final r = i.isEven ? outer : inner;
      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    return path..close();
  }

  // Smooth 0→1→0 pulse with phase offset
  double _pulse(double phase) =>
      (sin((t + phase) * 2 * pi) + 1) / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Large centre star — always mostly visible, pulses between 80–100%
    final s1 = 0.8 + _pulse(0.0) * 0.2;
    _drawStar(canvas, Offset(cx - 8, cy), 34 * s1, s1);

    // Medium upper-right star — pulses between 60–100%, offset phase
    final s2 = 0.6 + _pulse(0.25) * 0.4;
    _drawStar(canvas, Offset(cx + 28, cy - 26), 18 * s2, s2);

    // Small lower-left star — pulses between 40–100%, offset phase
    final s3 = 0.4 + _pulse(0.55) * 0.6;
    _drawStar(canvas, Offset(cx - 26, cy + 24), 11 * s3, s3);
  }

  @override
  bool shouldRepaint(_SparklePainter old) => old.t != t;
}
