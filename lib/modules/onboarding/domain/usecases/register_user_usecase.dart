import 'package:dartz/dartz.dart';
import 'package:grade_management_app/global/configs/failure.dart';
import 'package:grade_management_app/global/configs/usecase.dart';
import 'package:grade_management_app/modules/onboarding/domain/entites/user_entity.dart';
import 'package:grade_management_app/modules/onboarding/domain/repositories/repository.dart';

class RegisterUserUsecase extends UseCase<UserEntity, Params> {
  final UserRepository repository;
   RegisterUserUsecase(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(Params param) {
    return repository.registerUser(param.email, param.password);
  }

}