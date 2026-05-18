import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';
import '../repositories/authentication_repository.dart';

@injectable
class AuthenticationUseCase {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationUseCase(this._authenticationRepository);

  Future<Either<Failure, void>> signInWithGoogle() async {
    return await _authenticationRepository.signInWithGoogle();
  }

  Future<Either<Failure, void>> signOut() async {
    return await _authenticationRepository.signOut();
  }
}
