import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/usecases/updaate_username_usecase.dart';

part 'update_username_bloc.freezed.dart';
part 'update_username_event.dart';
part 'update_username_state.dart';

class UpdateUsernameBloc extends Bloc<UpdateUsernameEvent, UpdateUsernameState> {
  final UpdateUsernameUsecase updateUsernameUsecase;
  UpdateUsernameBloc(this.updateUsernameUsecase) : super(const _Initial()) {
    on<UpdateUsername>(_onUpdateUsername);
  }

  FutureOr<void> _onUpdateUsername(event, emit) async {
    emit(const _Loading());

    final result = await updateUsernameUsecase.call(event.username);
    result.fold(
      (l) {
        emit(_Error(l.message));
      },
      (r) {
        emit(const _Loaded());
      },
    );
  }
}
