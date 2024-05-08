import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_management_app/locator.dart';
import 'package:grade_management_app/modules/onboarding/login/bloc/login_bloc.dart';
import 'package:grade_management_app/modules/onboarding/signup/bloc/signup_bloc/signup_bloc.dart';
import 'package:grade_management_app/modules/onboarding/signup/bloc/update_username_bloc/bloc/update_username_bloc.dart';

class AppProvider {
  static getList() {
    return [
      BlocProvider(
        create: (context) => locator<LoginBloc>(),
      ),
      BlocProvider(
        create: (context) => locator<SignupBloc>(),
      ),
      BlocProvider(create: (context) => locator<UpdateUsernameBloc>())
    ];
  }
}
