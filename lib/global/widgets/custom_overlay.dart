import 'package:flutter/material.dart';
import 'package:grade_management_app/global/constants/spacing.dart';

class CustomOverlay extends StatelessWidget {
  const CustomOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 27,
              width: double.infinity,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.arrow_back),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.1647,
            ),
            Image.asset(
              'assets/eye_sad.png',
              scale: 2,
            ),
            const VerticalSpacing(47),
            const Text(
              '😯 Oops!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xff000000),
              ),
            ),
            const VerticalSpacing(9),
            const Text(
              'Dodge screen mode activated',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xffA1A6C4),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
