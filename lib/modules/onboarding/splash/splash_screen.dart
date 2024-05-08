import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/widgets/design_button.dart';
import 'package:grade_management_app/modules/onboarding/login/pages/login_bottom_sheet.dart';
import 'package:grade_management_app/modules/onboarding/signup/pages/signup_bottom_sheet.dart';
import 'package:grade_management_app/modules/onboarding/widgets/splash_animated_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFCAEEA3),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const HorizontalSpacing(double.infinity),
                    const VerticalSpacing(436),
                    AnimatedEclipse(animation: _animation),
                    const VerticalSpacing(74),
                    const Text(
                      'Calculate your GPA',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const VerticalSpacing(12),
                    const Text(
                      'Keep track of your GPA with the most \nbeautifully designed and intuitive GPA \ncalculator',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const VerticalSpacing(32),
                    DesignButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => const LoginBottomSheet());
                        },
                        text: 'Login'),
                    const VerticalSpacing(16),
                    RichText(
                      text: TextSpan(
                          text: 'Don’t have an account? ',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Create one',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          const SignupBottomSheet());
                                },
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            )
                          ]),
                    )
                  ],
                ),
                const Positioned(
                  left: 0,
                  right: 0,
                  child: AnimatedBoy(),
                )
              ],
            ),
          ),
        ));
  }
}


