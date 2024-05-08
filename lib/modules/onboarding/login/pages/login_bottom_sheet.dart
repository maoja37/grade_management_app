// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/utils/custom_input_border.dart';
import 'package:grade_management_app/global/widgets/bottom_sheet_notch.dart';
import 'package:grade_management_app/global/widgets/custom_toast.dart';
import 'package:grade_management_app/global/widgets/design_button.dart';
import 'package:grade_management_app/modules/dashboard/dashboard_wrapper.dart';
import 'package:grade_management_app/modules/onboarding/login/bloc/login_bloc.dart';
import 'package:iconsax/iconsax.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  bool _isLoading = false;
  //this key is used to validate the forms
  final formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loaded: () {
            setState(() {
              _isLoading = false;
            });
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const DashboardWrapper(),
              ),
            );
          },
          error: (e) {
            setState(() {
              _isLoading = false;
            });
            showErrorToast(e, context);
          },
        );
      },
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xffFEFCF6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HorizontalSpacing(double.infinity),
                  const VerticalSpacing(8),
                  const BottomSheetNotch(),
                  const VerticalSpacing(36),
                  SvgPicture.asset('assets/oc-hi-five.svg'),
                  const VerticalSpacing(16),
                  const Text(
                    'Welcome back!',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  const VerticalSpacing(32),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Color(0xffABACA5)),
                      prefixIcon: const Icon(
                        Iconsax.messages,
                        size: 24,
                      ),
                      border: CustomOutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xffABACA5),
                        ),
                      ),
                      enabledBorder: CustomOutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xffABACA5),
                        ),
                      ),
                      focusedBorder: CustomOutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xffABACA5),
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpacing(16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Color(0xffABACA5)),
                      prefixIcon: const Icon(
                        Iconsax.lock_1,
                        size: 24,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: _toggleObscureText,
                        child: Icon(
                          _obscureText ? Iconsax.eye : Iconsax.eye_slash,
                          size: 24,
                        ),
                      ),
                      border: CustomOutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xffABACA5),
                        ),
                      ),
                      enabledBorder: CustomOutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xffABACA5),
                        ),
                      ),
                      focusedBorder: CustomOutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xffABACA5),
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpacing(24),
                  DesignButton(
                      loading: _isLoading,
                      onPressed: () {
                        //this conditonal checks if the form is valid for submission or not and only then does it try to login the user
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          context.read<LoginBloc>().add(LoginUserEvent(
                              email: _emailController.text,
                              password: _passwordController.text));
                        }
                      },
                      text: 'Login'),
                  const VerticalSpacing(32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showErrorToast(String e, BuildContext context) {
    if (e == 'invalid-email') {
      context.showToast(
          message: 'Error Updating Name',
          backgroundColor: const Color(0xffFCEEEE),
          textColor: const Color(0xffEA0000));
    } else if (e == 'user-disabled') {
      context.showToast(
          message: 'User disabled',
          backgroundColor: const Color(0xffFCEEEE),
          textColor: const Color(0xffEA0000));
    } else if (e == 'wrong-password') {
      context.showToast(
          message: 'Wrong Password entered',
          backgroundColor: const Color(0xffFCEEEE),
          textColor: const Color(0xffEA0000));
    } else if (e == 'user-not-found') {
      context.showToast(
          message: 'User not found',
          backgroundColor: const Color(0xffFCEEEE),
          textColor: const Color(0xffEA0000));
    } else {
      context.showToast(
          message: 'Something went wrong',
          backgroundColor: const Color(0xffFCEEEE),
          textColor: const Color(0xffEA0000));
    }
  }
}
