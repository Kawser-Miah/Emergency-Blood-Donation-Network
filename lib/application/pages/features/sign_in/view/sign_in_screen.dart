import 'package:blood_setu/application/pages/features/sign_in/bloc/sign_in_event.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/sparkle_loading_overlay.dart';
import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_state.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInBloc>(),
      child: const SignIn(),
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SuccessSignState) {
          Utils.showSnackBar(
            context,
            content: 'Welcome! Let’s save lives together.',
            color: Colors.green,
          );
        }
        if (state is FailureState) {
          Utils.showSnackBar(
            context,
            content: state.message,
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is LoadingSignInState;
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  const _IllustrationArea(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome to Blood Connect',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Join thousands of donors saving lives across Bangladesh. Every drop counts.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textTertiary,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const _FeatureRow(
                            emoji: '🔍',
                            text: 'Find nearby donors instantly',
                          ),
                          const SizedBox(height: 12),
                          const _FeatureRow(
                            emoji: '🚨',
                            text: 'Emergency SOS broadcast',
                          ),
                          const SizedBox(height: 12),
                          const _FeatureRow(
                            emoji: '🏅',
                            text: 'Earn badges for donations',
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () => context.read<SignInBloc>().add(
                                      SignInEvent.googleSignInPressed(),
                                    ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 4,
                                shadowColor: AppColors.primary.withValues(
                                  alpha: 0.35,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.g_mobiledata,
                                      size: 22,
                                      color: AppColors.googleBlue,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'By continuing, you agree to our ',
                                  ),
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                  TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.textMuted,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading) const SparkleLoadingOverlay(),
          ],
        );
      },
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.emoji, required this.text});

  final String emoji;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _IllustrationArea extends StatefulWidget {
  const _IllustrationArea();

  @override
  State<_IllustrationArea> createState() => _IllustrationAreaState();
}

class _IllustrationAreaState extends State<_IllustrationArea>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300 + MediaQuery.of(context).padding.top,
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.5, 1.0],
                  colors: [
                    AppColors.primaryDark,
                    AppColors.primary,
                    AppColors.primaryLight,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final dy = -6 * _controller.value;
                return Transform.translate(offset: Offset(0, dy), child: child);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.water_drop,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      _IllustrationStat(
                        icon: Icons.favorite,
                        label: '12K+ Donors',
                      ),
                      SizedBox(width: 16),
                      _IllustrationStat(
                        icon: Icons.people,
                        label: '8K+ Lives Saved',
                      ),
                      SizedBox(width: 16),
                      _IllustrationStat(
                        icon: Icons.shield,
                        label: '100% Verified',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IllustrationStat extends StatelessWidget {
  const _IllustrationStat({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.white.withValues(alpha: 0.9)),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9, color: Colors.white.withValues(alpha: 0.85)),
        ),
      ],
    );
  }
}
