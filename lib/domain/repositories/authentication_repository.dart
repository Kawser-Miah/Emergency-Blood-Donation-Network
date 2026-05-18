import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, void>> signInWithGoogle();
  Future<Either<Failure, void>> signOut();
}
