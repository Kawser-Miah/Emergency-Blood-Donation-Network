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
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthenticationRepositoriesIml(this._firebaseAuth, this._firebaseFirestore);

  @override
  Future<Either<Failure, void>> signInWithGoogle() async {
    try {
      // await _googleSignIn.initialize();

      /// Trigger Google Sign In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {

        return Left(GeneralFailure('Google sign in cancelled'));
      }

      /// Get authentication details

      print("Kawser-1");
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      /// Create firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      /// Sign in to Firebase
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      final user = userCredential.user;

      if (user != null) {
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
      }

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return Left(
        GeneralFailure(e.message ?? 'Firebase authentication failed'),
      );
    } catch (e) {
      print("object");
      print(e);
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);

      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
