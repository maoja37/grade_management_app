import 'package:flutter/material.dart';

class BottomSheetNotch extends StatelessWidget {
  const BottomSheetNotch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
          color: const Color(0xffABACA5),
          borderRadius: BorderRadius.circular(50)),
    );
  }
}
