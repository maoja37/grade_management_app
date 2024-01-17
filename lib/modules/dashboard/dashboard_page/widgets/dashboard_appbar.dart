import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/services/auth_service.dart';

class DashboardAppbar extends StatelessWidget {
  final AuthService _authService = AuthService();
  DashboardAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = _authService.auth.currentUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.only(bottom: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xffDF883A),
                child: Text(
                  currentUser != null
                      ? currentUser.displayName != null
                          ? currentUser.displayName!
                              .substring(0, 1)
                              .toUpperCase()
                          : 'U'
                      : 'O',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              const HorizontalSpacing(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTextKit(totalRepeatCount: 2, animatedTexts: [
                    WavyAnimatedText(
                     currentUser?.displayName ?? 'User',
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ]),
                  const VerticalSpacing(2),
                  Text(
                    currentUser != null
                        ? currentUser.email!
                        : 'Email@gmail.com',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ],
          ),
          Container(),
        ],
      ),
    );
  }
}
