import 'package:blood_setu/application/core/services/sp_service/sp_service.dart';
import 'package:blood_setu/domain/repositories/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../domain/failures/failures.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoriesIml extends AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final GoogleSignIn _googleSignIn;
  final SpService _spService;

  AuthenticationRepositoriesIml(
    this._firebaseAuth,
    this._firebaseFirestore,
    this._googleSignIn,
    this._spService,
  );

  @override
  Future<Either<Failure, bool>> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();

      /// Trigger Google Sign In
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // if (googleUser == null) {
      //
      //   return Left(GeneralFailure('Google sign in cancelled'));
      // }

      /// Get authentication details

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      /// Create firebase credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      /// Sign in to Firebase
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      final user = userCredential.user;

      if (user != null) {
        /// profile collection check
        final profileDoc = _firebaseFirestore
            .collection('profile')
            .doc(user.uid);

        final profileSnapshot = await profileDoc.get();

        final userDoc = _firebaseFirestore.collection('users').doc(user.uid);

        final docSnapshot = await userDoc.get();

        /// Save user data if new user
        if (!docSnapshot.exists) {
          await userDoc.set({
            'uid': user.uid,
            'name': user.displayName,
            'email': user.email,
            'photoUrl': user.photoURL,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }

        return Right(profileSnapshot.exists);
      }

      return Left(GeneralFailure("User is null"));
    } on FirebaseAuthException catch (e) {
      return Left(
        GeneralFailure(e.message ?? 'Firebase authentication failed'),
      );
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        _spService.clearAll(),
      ]);

      return const Right(null);
    } catch (e) {
      return Left(
        GeneralFailure("An unexpected error occurred during sign out."),
      );
    }
  }
}
