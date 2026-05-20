import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, bool>> signInWithGoogle();
  Future<Either<Failure, void>> signOut();
}
