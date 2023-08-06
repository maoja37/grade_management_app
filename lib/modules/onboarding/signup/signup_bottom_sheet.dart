import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grade_management_app/global/auth_service.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/utils/custom_input_border.dart';
import 'package:grade_management_app/global/widgets/bottom_sheet_notch.dart';
import 'package:grade_management_app/global/widgets/design_button.dart';
import 'package:grade_management_app/modules/onboarding/signup/update_username_bottom_sheet.dart';
import 'package:iconsax/iconsax.dart';

class SignupBottomSheet extends StatefulWidget {
  const SignupBottomSheet({super.key});

  @override
  State<SignupBottomSheet> createState() => _SignupBottomSheetState();
}

class _SignupBottomSheetState extends State<SignupBottomSheet> {
  final AuthService _authService = AuthService();
  //this key is used for form validation
  final _formKey = GlobalKey<FormState>();

  //this controllers are used to get the values from the appropriate text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  late UpdateUsernameBottomSheet _updateUsernameBottomSheet;

  @override
  void initState() {
    // TODO: implement initState
    _updateUsernameBottomSheet = UpdateUsernameBottomSheet();
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          _authService.registerWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                          Navigator.pop(context);

                          ScaffoldMessenger.of(_formKey.currentState!.context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'Account created successfully, Proceed to login'),
                          ));
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => _updateUsernameBottomSheet);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(_formKey.currentState!.context)
                                .showSnackBar(const SnackBar(
                              content: Text('Password is too weak'),
                            ));
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(_formKey.currentState!.context)
                                .showSnackBar(const SnackBar(
                              content: Text('Email already in use'),
                            ));
                          } else if (e.code == 'network-request-failed') {
                            ScaffoldMessenger.of(_formKey.currentState!.context)
                                .showSnackBar(const SnackBar(
                              content: Text('There was a network error'),
                            ));
                          } else {
                            ScaffoldMessenger.of(_formKey.currentState!.context)
                                .showSnackBar(const SnackBar(
                              content: Text('Something went wrong'),
                            ));
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
