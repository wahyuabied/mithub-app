
import 'package:mithub_app/data/dto_user_login.dart';

abstract class LoginResult {
  factory LoginResult.immediateLogin(PostUserLoginResponse data) =>
      ImmediateLogin(data);

  factory LoginResult.pinExpired() => LoginResult.pinExpired();

  factory LoginResult.wrongPin() => WrongPin();

  factory LoginResult.tooMuchAttempt(String message) => TooMuchAttempt(message);

  factory LoginResult.failed() => Failed();
}

class ImmediateLogin implements LoginResult {
  final PostUserLoginResponse data;

  ImmediateLogin(this.data);
}


class PinExpired implements LoginResult {}

class WrongPin implements LoginResult {}

class TooMuchAttempt implements LoginResult {
  final String message;

  TooMuchAttempt(this.message);
}

class Failed implements LoginResult {}
