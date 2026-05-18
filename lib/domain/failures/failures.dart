abstract class Failure {}

class UserNotFoundFailure extends Failure {}

class InvalidCredentialFailure extends Failure {}

class UserDisabledFailure extends Failure {}

class WrongPasswordFailure extends Failure {}

class GeneralFailure extends Failure {
  String message;
  GeneralFailure(this.message);
}

class InvalidEmailFailure extends Failure {}

class UnknownAuthFailure extends Failure {}

class EmailAlreadyInUseFailure extends Failure {}

class WeakPasswordFailure extends Failure {}

class UserMismatchFailure extends Failure {}

class UnexpectedFailure extends Failure {
  String message;
  UnexpectedFailure(this.message);
}

class NullFailure extends Failure {}