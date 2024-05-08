import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
  @override
  List<Object> get props => [message];
}

class LoginFailure extends Failure {
  const LoginFailure({required super.message});
}


class SignupFailure extends Failure {
  const SignupFailure({required super.message});
}
