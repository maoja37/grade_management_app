import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grade_management_app/global/auth_service.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/utils/custom_input_border.dart';
import 'package:grade_management_app/global/widgets/bottom_sheet_notch.dart';
import 'package:grade_management_app/global/widgets/design_button.dart';
import 'package:grade_management_app/modules/dashboard/dashboard_wrapper.dart';
import 'package:iconsax/iconsax.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final AuthService _authService = AuthService();
  //this key is used to validate the forms
  final formKey = GlobalKey<FormState>();

//this controllers are used to get the values from the appropriate text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    onPressed: () async {
                      //this conditonal checks if the form is valid for submission or not and only then does it try to login the user
                      if (formKey.currentState!.validate()) {
                        try {
                          //when this button is pressed the loading variable is set to true and the CircularProgressIndicator is shown
                          _authService.signInWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                          print(_authService.auth.currentUser);
                          Navigator.pop(context);
                          User? user = _authService.auth.currentUser;
                          if (user != null) {
                            if (user.email != null) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DashboardWrapper(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(
                                      formKey.currentState!.context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Something went wrong'),
                              ));
                            }
                          }
                        } on FirebaseAuthException catch (e) {
                          //when the exception is caught the loading variable is set to false and the CircularProgressIndicator is hidden

                          if (e.code == 'invalid-email') {
                            ScaffoldMessenger.of(formKey.currentState!.context)
                                .showSnackBar(const SnackBar(
                              content: Text('Please enter valid email'),
                            ));
                          } else if (e.code == 'user-disabled') {
                            ScaffoldMessenger.of(formKey.currentState!.context)
                                .showSnackBar(const SnackBar(
                              content: Text('User disabled'),
                            ));
                          } else if (e.code == 'wrong-password') {
                            ScaffoldMessenger.of(formKey.currentState!.context)
                                .showSnackBar(const SnackBar(
                              content: Text('Wrong Password entered'),
                            ));
                          } else if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(formKey.currentState!.context)
                                .showSnackBar(const SnackBar(
                              content: Text('User not found'),
                            ));
                          } else {
                            ScaffoldMessenger.of(formKey.currentState!.context)
                                .showSnackBar(const SnackBar(
                              content: Text('User disabled'),
                            ));
                          }
                        }
                      }
                    },
                    text: 'Login'),
                const VerticalSpacing(32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
