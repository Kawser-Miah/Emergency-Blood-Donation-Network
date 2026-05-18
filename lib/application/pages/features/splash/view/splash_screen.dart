import 'package:blood_setu/application/core/services/routing/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/models/screen.dart';
import '../../../../core/services/routing/routing_utils.dart';
import '../../../../core/theme/colors.dart';
import '../../../app/bloc/app_navigation_bloc.dart';
import '../../../app/bloc/app_navigation_event.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(),
      child: BlocListener<SplashBloc, SplashState>(
        listenWhen: (prev, next) => !prev.finished && next.finished,
        listener: (context, state) {
          final user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            /// User already logged in
            // context.read<AppNavigationBloc>().add(
            //   const AppNavigationEvent.navigated(AppScreen.home),
            // );
            AppRouter.router.pushReplacement(PAGES.home.screenPath);
          } else {
            /// User not logged in
            // context.read<AppNavigationBloc>().add(
            //   const AppNavigationEvent.navigated(AppScreen.signin),
            // );
            AppRouter.router.pushReplacement(PAGES.signin.screenPath);
          }
        },
        child: const _SplashContent(),
      ),
    );
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
      child: Column(
        children: [
          const Expanded(child: _CenterLogo()),
          _BottomButtons(
            onSignIn: () => context.read<AppNavigationBloc>().add(
              const AppNavigationEvent.navigated(AppScreen.signin),
            ),
            onGuest: () => context.read<AppNavigationBloc>().add(
              const AppNavigationEvent.navigated(AppScreen.home),
            ),
          ),
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
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.primaryDark],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    color: Colors.white,
                    size: 36,
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
            color: AppColors.primary.withOpacity(0.06),
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
              color: AppColors.primary.withOpacity(opacity),
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

class _BottomButtons extends StatelessWidget {
  const _BottomButtons({required this.onSignIn, required this.onGuest});

  final VoidCallback onSignIn;
  final VoidCallback onGuest;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onSignIn,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: const BorderSide(color: AppColors.primary, width: 2),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.g_mobiledata, size: 24, color: AppColors.googleBlue),
                SizedBox(width: 8),
                Text(
                  'Sign in with Google',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: onGuest,
          child: const Text(
            'Continue as Guest',
            style: TextStyle(color: AppColors.textMuted, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
