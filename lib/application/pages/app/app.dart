import 'package:blood_setu/application/core/services/routing/app_router.dart';
import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';


class BloodConnectApp extends StatelessWidget {
  const BloodConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Blood Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: AppColors.fontFamily,
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: false,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
        ),
      ),
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routerDelegate: AppRouter.router.routerDelegate,
    );
  }
}