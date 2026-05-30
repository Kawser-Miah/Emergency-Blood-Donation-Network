import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:blood_setu/domain/repositories/registration_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegistrationRepository)
class RegistrationRepositoryIml extends RegistrationRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  RegistrationRepositoryIml(this._firebaseAuth, this._firebaseFirestore);

  @override
  Future<Either<Failure, void>> register(UserProfileModel userProfile) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Left(
          GeneralFailure(
            'No authenticated session found. Please sign in and try again.',
          ),
        );
      }

      final submittedName = userProfile.fullName?.trim() ?? '';
      final currentDisplayName = user.displayName?.trim() ?? '';
      if (submittedName.isNotEmpty && submittedName != currentDisplayName) {
        await user.updateDisplayName(submittedName);
      }

      final finalProfile = userProfile.copyWith(
        userUuid: user.uid,
        email: user.email,
        photoUrl: user.photoURL,
      );

      final docRef = _firebaseFirestore.collection('profile').doc(user.uid);
      await docRef.set(finalProfile.toMap(), SetOptions(merge: true));

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(
        GeneralFailure(
          e.message ??
              'Failed to update authentication profile. Please try again.',
        ),
      );
    } on FirebaseException catch (e) {
      return Left(
        GeneralFailure(
          e.message ?? 'A database error occurred. Please try again later.',
        ),
      );
    } catch (e) {
      return Left(
        GeneralFailure(
          'An unexpected error occurred during registration. Please try again.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserProfileModel>> getProfile(String uid) async {
    try {
      final doc = await _firebaseFirestore.collection('profile').doc(uid).get();

      if (!doc.exists) {
        return Left(GeneralFailure('Profile not found.'));
      }

      return Right(UserProfileModel.fromFirestore(doc));
    } on FirebaseException catch (e) {
      return Left(GeneralFailure(e.message ?? 'Failed to load profile.'));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
