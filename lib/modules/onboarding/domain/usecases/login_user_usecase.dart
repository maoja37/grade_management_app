import 'package:dartz/dartz.dart';
import 'package:grade_management_app/global/configs/failure.dart';
import 'package:grade_management_app/global/configs/usecase.dart';
import 'package:grade_management_app/modules/onboarding/domain/entites/user_entity.dart';
import 'package:grade_management_app/modules/onboarding/domain/repositories/repository.dart';

class LoginUserUsecase implements UseCase<UserEntity, Params> {
  final UserRepository repository;

  LoginUserUsecase(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(Params param) async{
   return await repository.loginUser(param.email, param.password);
  }

}

