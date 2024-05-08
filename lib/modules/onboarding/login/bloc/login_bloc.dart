import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grade_management_app/global/configs/usecase.dart';
import 'package:grade_management_app/modules/onboarding/domain/usecases/login_user_usecase.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase loginUserUsecase;
  LoginBloc({required this.loginUserUsecase}) : super(const _Initial()) {
    on<LoginUserEvent>(_onLoginUserEvent);
  }

  FutureOr<void> _onLoginUserEvent(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(const _Loading());
    final result = await loginUserUsecase
        .call(Params(email: event.email, password: event.password));

    result.fold(
      (failure) {
        emit(_Error(failure.message));
      },
      (userEntity) {
        emit(const _Loaded());
      },
    );
  }
}
