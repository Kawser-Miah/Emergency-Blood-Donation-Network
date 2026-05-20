import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/application/core/services/routing/app_router.dart';
import 'package:blood_setu/application/core/services/sp_service/sp_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'application/pages/app/app.dart';
import 'di/di.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await configureDependencies();

  // final authController = AuthController(getIt<SpService>());
  // final appRouter = AppRouter(authController);
  //
  // getIt.registerSingleton<AuthController>(authController);
  // getIt.registerSingleton<AppRouter>(appRouter);

  runApp(const BloodConnectApp());
}
