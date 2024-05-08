part of 'update_username_bloc.dart';

@freezed
class UpdateUsernameEvent with _$UpdateUsernameEvent {
  const factory UpdateUsernameEvent.updateUsername({required String username}) = UpdateUsername;
}