part of 'signup_bloc.dart';

@freezed
class SignupEvent with _$SignupEvent {
  const factory SignupEvent.registerUser({required String email, required String password}) = RegisterUser;
}