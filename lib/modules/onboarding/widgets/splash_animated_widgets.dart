import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grade_management_app/global/constants/spacing.dart';

class AnimatedBoy extends StatelessWidget {
  const AnimatedBoy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Animator<double>(
        duration: const Duration(milliseconds: 1000),
        cycles: 0,
        curve: Curves.linear,
        tween: Tween<double>(begin: 210, end: 220),
        builder: (context, animatorState, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VerticalSpacing(animatorState.value),
              SvgPicture.asset('assets/oc-on-the-laptop.svg'),
            ],
          );
        });
  }
}

class AnimatedEclipse extends StatelessWidget {
  const AnimatedEclipse({
    super.key,
    required Animation<double> animation,
  }) : _animation = animation;

  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: SvgPicture.asset(
                'assets/oc-on-the-laptop-ellipse.svg'),
          );
        });
  }
}