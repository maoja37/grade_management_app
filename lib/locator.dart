import 'package:get_it/get_it.dart';
import 'package:grade_management_app/modules/onboarding/data/datasources/remote_data_sources.dart';
import 'package:grade_management_app/modules/onboarding/data/repository_impl/repsoritory_impl.dart';
import 'package:grade_management_app/modules/onboarding/domain/repositories/repository.dart';
import 'package:grade_management_app/modules/onboarding/domain/usecases/login_user_usecase.dart';
import 'package:grade_management_app/modules/onboarding/domain/usecases/register_user_usecase.dart';
import 'package:grade_management_app/modules/onboarding/domain/usecases/updaate_username_usecase.dart';
import 'package:grade_management_app/modules/onboarding/login/bloc/login_bloc.dart';
import 'package:grade_management_app/modules/onboarding/signup/bloc/signup_bloc/signup_bloc.dart';
import 'package:grade_management_app/modules/onboarding/signup/bloc/update_username_bloc/bloc/update_username_bloc.dart';

final locator = GetIt.instance;

Future<void> setupServices() async {
  locator.registerFactory<LoginBloc>(
    () => LoginBloc(loginUserUsecase: locator()),
  );

  locator.registerFactory<SignupBloc>(
    () => SignupBloc(locator()),
  );

  locator.registerFactory(() => UpdateUsernameBloc(locator()));

  //use cases
  locator.registerLazySingleton<LoginUserUsecase>(
      () => LoginUserUsecase(locator()));

  locator.registerLazySingleton<RegisterUserUsecase>(
    () => RegisterUserUsecase(locator()),
  );

  locator.registerLazySingleton(() => UpdateUsernameUsecase(repository: locator()));

  //repositories
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: locator()));

  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
}
