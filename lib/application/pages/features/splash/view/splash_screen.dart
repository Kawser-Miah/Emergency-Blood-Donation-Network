import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SplashContent();
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.6, 1.0],
            colors: [
              Colors.white,
              AppColors.primarySurfaceLight,
              AppColors.primarySurfaceLighter,
            ],
          ),
        ),
        padding: EdgeInsets.fromLTRB(
          24,
          MediaQuery.of(context).padding.top + 36,
          24,
          MediaQuery.of(context).padding.bottom + 14,
        ),
        child: const Column(
          children: [
            Expanded(child: _CenterLogo()),
          ],
        ),
      ),
    );
  }
}

class _CenterLogo extends StatefulWidget {
  const _CenterLogo();

  @override
  State<_CenterLogo> createState() => _CenterLogoState();
}

class _CenterLogoState extends State<_CenterLogo>
    with TickerProviderStateMixin {
  late final AnimationController _ripple1;
  late final AnimationController _ripple2;
  late final AnimationController _logoScale;

  @override
  void initState() {
    super.initState();
    _ripple1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _ripple2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _ripple2.repeat();
    });
    _logoScale = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ripple1.dispose();
    _ripple2.dispose();
    _logoScale.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 130,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _Ripple(controller: _ripple1, size: 120, baseOpacity: 0.3),
              _Ripple(controller: _ripple2, size: 96, baseOpacity: 0.4),
              AnimatedBuilder(
                animation: _logoScale,
                builder: (context, child) {
                  final scale = 1 + 0.08 * _logoScale.value;
                  return Transform.scale(scale: scale, child: child);
                },
                child: Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/app_logo.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Blood Connect',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Connecting Donors, Saving Lives',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: AppColors.textTertiary),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _StatItem(value: '12K+', label: 'Donors'),
              _StatDivider(),
              _StatItem(value: '8K+', label: 'Lives Saved'),
              _StatDivider(),
              _StatItem(value: '64', label: 'Districts'),
            ],
          ),
        ),
      ],
    );
  }
}

class _Ripple extends StatelessWidget {
  const _Ripple({
    required this.controller,
    required this.size,
    required this.baseOpacity,
  });

  final AnimationController controller;
  final double size;
  final double baseOpacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.value;
        final scale = 1 + 0.5 * t;
        final opacity = baseOpacity * (1 - t);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: opacity),
            ),
          ),
        );
      },
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textTertiary),
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      color: AppColors.primaryBorder,
      margin: const EdgeInsets.symmetric(horizontal: 12),
    );
  }
}
