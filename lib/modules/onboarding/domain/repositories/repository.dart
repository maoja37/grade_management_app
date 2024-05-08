import 'package:dartz/dartz.dart';
import 'package:grade_management_app/global/configs/failure.dart';
import 'package:grade_management_app/modules/onboarding/domain/entites/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> loginUser(String email, String password);
  Future<Either<Failure, UserEntity>> registerUser(String name, String password);
    Future<Either<Failure, UserEntity>> getUser(String id);
  Future<Either<Failure, void>> updateUsername(String username);

}