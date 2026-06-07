import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/application/core/services/routing/routing_utils.dart';
import 'package:blood_setu/application/pages/features/bottom_nav/view/bottom_nav_page.dart';
import 'package:blood_setu/application/pages/features/create_request/view/create_request_screen.dart';
import 'package:blood_setu/application/pages/features/registration/view/registration_screen.dart';
import 'package:blood_setu/application/pages/features/sign_in/view/sign_in_screen.dart';
import 'package:blood_setu/application/pages/features/splash/view/splash_screen.dart';
import 'package:blood_setu/di/di.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../../pages/features/blood_requests/view/blood_requests_screen.dart';
import '../../../pages/features/chat_list/view/chat_list_screen.dart';
import '../../../pages/features/donors/view/donors_screen.dart';
import '../../../pages/features/map_picker/map_picker_screen.dart';
import '../../../pages/features/profile/view/profile_screen.dart';

@lazySingleton
class AppRouter {
  final AuthController _authController;

  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  late final GoRouter _goRouter;

  AppRouter(this._authController) {
    _goRouter = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: rootNavigatorKey,
      refreshListenable: _authController,
      redirect: (context, state) {
        final currentPath = state.fullPath;

        if (!_authController.isInitialized) {
          return PAGES.splash.screenPath;
        }

        if (_authController.user == null) {
          if (currentPath == PAGES.signin.screenPath) return null;
          return PAGES.signin.screenPath;
        }

        if (!_authController.profileCompleted) {
          if (currentPath == PAGES.register.screenPath) return null;
          return PAGES.register.screenPath;
        }

        if (currentPath == PAGES.signin.screenPath ||
            currentPath == PAGES.register.screenPath ||
            currentPath == PAGES.splash.screenPath) {
          return PAGES.home.screenPath;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: PAGES.splash.screenPath,
          name: PAGES.splash.screenName,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: PAGES.signin.screenPath,
          name: PAGES.signin.screenName,
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: PAGES.register.screenPath,
          name: PAGES.register.screenName,
          builder: (context, state) => const RegistrationScreen(),
        ),
        GoRoute(
          path: PAGES.home.screenPath,
          name: PAGES.home.screenName,
          builder: (context, state) => const BottomNavPage(),
        ),
        GoRoute(
          path: PAGES.createRequest.screenPath,
          name: PAGES.createRequest.screenName,
          builder: (context, state) => const CreateRequestScreen(),
        ),
        GoRoute(
          path: PAGES.donors.screenPath,
          name: PAGES.donors.screenName,
          builder: (context, state) => const DonorsScreen(),
        ),
        GoRoute(
          path: PAGES.bloodRequests.screenPath,
          name: PAGES.bloodRequests.screenName,
          builder: (context, state) => const BloodRequestsScreen(),
        ),
        GoRoute(
          path: PAGES.chats.screenPath,
          name: PAGES.chats.screenName,
          builder: (context, state) => const ChatListScreen(),
        ),
        GoRoute(
          path: PAGES.profile.screenPath,
          name: PAGES.profile.screenName,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: PAGES.mapPicker.screenPath,
          name: PAGES.mapPicker.screenName,
          builder: (context, state) {
            final extra =
                state.extra as ({double? initialLat, double? initialLng})?;
            return MapPickerScreen(
              initialLat: extra?.initialLat,
              initialLng: extra?.initialLng,
            );
          },
        ),
      ],
    );
  }

  // Static accessor kept for backward compatibility with existing call sites.
  static GoRouter get router => getIt<AppRouter>()._goRouter;
}
