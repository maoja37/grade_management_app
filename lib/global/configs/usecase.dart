import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:grade_management_app/global/configs/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params param);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class Params {
  final String email;
  final String password;

  Params({required this.email, required this.password});


}