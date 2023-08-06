import 'package:flutter/material.dart';

class DesignButton extends StatelessWidget {
  final bool loading;
  final void Function() onPressed;
  final String text;
  const DesignButton(
      {required this.onPressed,
      required this.text,
      this.loading = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.black,
      minWidth: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: loading
          ? const SizedBox(
              height: 11,
              width: 11,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ))
          : Text(
              text,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
    );
  }
}
