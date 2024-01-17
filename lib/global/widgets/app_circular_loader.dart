import 'package:flutter/material.dart';

class AppCircularLoader2 extends StatelessWidget {
  final Size size;
  const AppCircularLoader2({
    Key? key,
    this.size = const Size(20, 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: CircularProgressIndicator(
        strokeWidth: 12,
        valueColor: AlwaysStoppedAnimation<Color>(
          const Color(0xffA6B7D4).withOpacity(0.8),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}