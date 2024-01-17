// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/services/auth_service.dart';
import 'package:grade_management_app/global/utils/custom_input_border.dart';
import 'package:grade_management_app/global/widgets/bottom_sheet_notch.dart';
import 'package:grade_management_app/global/widgets/custom_toast.dart';
import 'package:grade_management_app/global/widgets/design_button.dart';
import 'package:grade_management_app/modules/onboarding/signup/update_username_bottom_sheet.dart';
import 'package:iconsax/iconsax.dart';

class SignupBottomSheet extends StatefulWidget {
  const SignupBottomSheet({super.key});

  @override
  State<SignupBottomSheet> createState() => _SignupBottomSheetState();
}

class _SignupBottomSheetState extends State<SignupBottomSheet> {
  bool _isLoading = false;
  final AuthService _authService = AuthService();
  //this key is used for form validation
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  late UpdateUsernameBottomSheet _updateUsernameBottomSheet;

  @override
  void initState() {
    //This is here for a reason
    _updateUsernameBottomSheet = const UpdateUsernameBottomSheet();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
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
                SvgPicture.asset('assets/oc-superhero.svg'),
                const VerticalSpacing(16),
                const Text(
                  'Create an Account',
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
                      return 'Please enter a password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        final currentContext = context;
                        try {
                          await _authService.registerWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                          Navigator.pop(currentContext);
                          currentContext.showToast(
                              message: 'Account created, please update name');

                          showModalBottomSheet(
                              context: currentContext,
                              isScrollControlled: true,
                              isDismissible: false,
                              builder: (context) => _updateUsernameBottomSheet);
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            _isLoading = false;
                          });
                          if (e.code == 'weak-password') {
                            currentContext.showToast(
                                message: 'Password is too weak',
                                backgroundColor: const Color(0xffFCEEEE),
                                textColor: const Color(0xffEA0000));
                          } else if (e.code == 'email-already-in-use') {
                            currentContext.showToast(
                                message: 'Email already in use',
                                backgroundColor: const Color(0xffFCEEEE),
                                textColor: const Color(0xffEA0000));
                          } else if (e.code == 'network-request-failed') {
                            currentContext.showToast(
                                message: 'There was a network error',
                                backgroundColor: const Color(0xffFCEEEE),
                                textColor: const Color(0xffEA0000));
                          } else {
                            currentContext.showToast(
                                message: 'Something went wrong',
                                backgroundColor: const Color(0xffFCEEEE),
                                textColor: const Color(0xffEA0000));
                          }
                        }
                      }
                    },
                    text: 'Create Account'),
                const VerticalSpacing(32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
