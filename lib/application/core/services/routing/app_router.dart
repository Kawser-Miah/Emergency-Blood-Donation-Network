import 'dart:async';

import 'package:blood_setu/application/core/services/routing/routing_utils.dart';
import 'package:blood_setu/application/pages/features/chat_list/view/chat_list_screen.dart';
import 'package:blood_setu/application/pages/features/create_request/view/create_request_screen.dart';
import 'package:blood_setu/application/pages/features/donors/view/donors_screen.dart';
import 'package:blood_setu/application/pages/features/home/view/home_screen.dart';
import 'package:blood_setu/application/pages/features/profile/view/profile_screen.dart';
import 'package:blood_setu/application/pages/features/registration/view/registration_screen.dart';
import 'package:blood_setu/application/pages/features/sign_in/view/sign_in_screen.dart';
import 'package:blood_setu/application/pages/features/splash/view/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,

    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),

    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;

      final currentPath = state.fullPath;

      /// Always allow splash screen
      if (currentPath == PAGES.splash.screenPath) {
        return null;
      }

      /// User not logged in
      if (user == null) {
        /// Allow only signin page
        if (currentPath == PAGES.signin.screenPath) {
          return null;
        }

        /// Redirect everything else to signin
        return PAGES.signin.screenPath;
      }

      /// User logged in
      /// Prevent going back to signin
      if (currentPath == PAGES.signin.screenPath) {
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
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: PAGES.donors.screenPath,
        name: PAGES.donors.screenName,
        builder: (context, state) => const DonorsScreen(),
      ),

      GoRoute(
        path: PAGES.chats.screenPath,
        name: PAGES.chats.screenName,
        builder: (context, state) => const ChatListScreen(),
      ),

      GoRoute(
        path: PAGES.createRequest.screenPath,
        name: PAGES.createRequest.screenName,
        builder: (context, state) => const CreateRequestScreen(),
      ),

      GoRoute(
        path: PAGES.profile.screenPath,
        name: PAGES.profile.screenName,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();

    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
