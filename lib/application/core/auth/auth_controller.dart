import 'dart:async';

import 'package:blood_setu/application/core/services/sp_service/sp_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthController extends ChangeNotifier {
  final SpService _spService;
  final FirebaseAuth _firebaseAuth;

  User? _user;
  bool _profileCompleted = false;
  bool _isInitialized = false;
  StreamSubscription<User?>? _authSubscription;

  AuthController(this._spService, this._firebaseAuth) {
    _init();
  }

  User? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get profileCompleted => _profileCompleted;
  bool get isInitialized => _isInitialized;

  Future<void> _init() async {
    _profileCompleted =
        _spService.readSync<bool>(StorageKey.register) ?? false;

    final authReady = Completer<void>();

    _authSubscription = _firebaseAuth.authStateChanges().listen((user) {
      _user = user;
      if (!authReady.isCompleted) authReady.complete();
      if (_isInitialized) notifyListeners();
    });

    // Show splash for at least 3 seconds and wait for Firebase auth state
    await Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      authReady.future,
    ]);

    _isInitialized = true;
    notifyListeners();
  }

  void onLoginSuccess({required bool profileExists}) {
    _profileCompleted = profileExists;
    _spService.write(profileExists, StorageKey.register);
    notifyListeners();
  }

  void onProfileCompleted() {
    _profileCompleted = true;
    _spService.write(true, StorageKey.register);
    notifyListeners();
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    _user = null;
    _profileCompleted = false;
    await _spService.delete(StorageKey.register);
    notifyListeners();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
