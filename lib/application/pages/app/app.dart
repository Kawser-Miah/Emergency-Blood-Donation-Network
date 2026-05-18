import 'package:blood_setu/application/core/services/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/screen.dart';
import '../../core/theme/colors.dart';
import '../features/chat/view/chat_screen.dart';
import '../features/chat_list/view/chat_list_screen.dart';
import '../features/create_request/view/create_request_screen.dart';
import '../features/donors/view/donors_screen.dart';
import '../features/home/view/home_screen.dart';
import '../features/profile/view/profile_screen.dart';
import '../features/registration/view/registration_screen.dart';
import '../features/sign_in/view/sign_in_screen.dart';
import '../features/splash/view/splash_screen.dart';
import 'bloc/app_navigation_bloc.dart';
import 'bloc/app_navigation_state.dart';

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
      ),
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routerDelegate: AppRouter.router.routerDelegate,
    );
  }
}

// class _AppShell extends StatelessWidget {
//   const _AppShell();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AppNavigationBloc, AppNavigationState>(
//       builder: (context, state) {
//         final bloc = context.read<AppNavigationBloc>();
//         final useLightStatusBar =
//             state.screen == AppScreen.signin ||
//             state.screen == AppScreen.profile;

        // return AnnotatedRegion<SystemUiOverlayStyle>(
        //   value: useLightStatusBar
        //       ? const SystemUiOverlayStyle(
        //           statusBarColor: Colors.transparent,
        //           statusBarIconBrightness: Brightness.light,
        //           statusBarBrightness: Brightness.dark,
        //         )
        //       : const SystemUiOverlayStyle(
        //           statusBarColor: Colors.transparent,
        //           statusBarIconBrightness: Brightness.dark,
        //           statusBarBrightness: Brightness.light,
        //         ),
        //   child: PopScope(
        //     canPop: !bloc.canPop,
        //     onPopInvokedWithResult: (bool didPop, dynamic result) {
        //       if (!didPop) bloc.pop();
        //     },
        //     child: Scaffold(
        //       body: _ScreenContent(state: state),
        //     ),
        //   ),
        // );
        // return Scaffold(body: _ScreenContent(state: state));
//       },
//     );
//   }
// }

// class _ScreenContent extends StatelessWidget {
//   const _ScreenContent({required this.state});
//
//   final AppNavigationState state;
//
//   @override
//   Widget build(BuildContext context) {
//     switch (state.screen) {
//       case AppScreen.splash:
//         return const SplashScreen();
//       case AppScreen.signin:
//         return const SignInScreen();
//       case AppScreen.register:
//         return const RegistrationScreen();
//       case AppScreen.home:
//         return const HomeScreen();
//       case AppScreen.donors:
//         return const DonorsScreen();
//       case AppScreen.chats:
//         return const ChatListScreen();
//       case AppScreen.chat:
//         return ChatScreen(contact: state.chatContact);
//       case AppScreen.createRequest:
//         return const CreateRequestScreen();
//       case AppScreen.profile:
//         return const ProfileScreen();
//     }
//   }
// }
