import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grade_management_app/global/configs/failure.dart';
import 'package:grade_management_app/modules/onboarding/data/datasources/remote_data_sources.dart';
import 'package:grade_management_app/modules/onboarding/domain/entites/user_entity.dart';
import 'package:grade_management_app/modules/onboarding/domain/repositories/repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, UserEntity>> getUser(String id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> loginUser(
      String email, String password) async {
    try {
      final result = await remoteDataSource.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(LoginFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerUser(
      String email, String password) async {
    try {
      final result = await remoteDataSource.registerWithEmailAndPassword(
          email: email, password: password);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(SignupFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, void>> updateUsername(String username) async {
    try {
      final result = await remoteDataSource.updateDisplayName(username);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(SignupFailure(message: e.code));
    }
  }
}
