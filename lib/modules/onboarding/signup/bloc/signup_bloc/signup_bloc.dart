import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grade_management_app/global/configs/usecase.dart';
import 'package:grade_management_app/modules/onboarding/domain/usecases/register_user_usecase.dart';

part 'signup_bloc.freezed.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final RegisterUserUsecase registerUserUsecase;
  SignupBloc(this.registerUserUsecase) : super(const _Initial()) {
    on<RegisterUser>(_onRegisterUser);
  }

  FutureOr<void> _onRegisterUser(
      RegisterUser event, Emitter<SignupState> emit) async {
    emit(const _Loading());
    final result = await registerUserUsecase
        .call(Params(email: event.email, password: event.password));

    result.fold(
      (l) {
        emit(_Error(message: l.message));
      },
      (r) {
        emit(const _Success()); 
      },
    );
  }
}
