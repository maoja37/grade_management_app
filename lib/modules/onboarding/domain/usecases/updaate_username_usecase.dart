import 'package:dartz/dartz.dart';
import 'package:grade_management_app/global/configs/failure.dart';
import 'package:grade_management_app/global/configs/usecase.dart';
import 'package:grade_management_app/modules/onboarding/domain/repositories/repository.dart';

class UpdateUsernameUsecase extends UseCase<void, String> {
  final UserRepository repository;

  UpdateUsernameUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(String param) {
    return repository.updateUsername(param);
  }
}
