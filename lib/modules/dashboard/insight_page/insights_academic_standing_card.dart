import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/utils/utility_functions.dart';

import '../models/models.dart';

class InsightsAcademicStandingCard extends StatefulWidget {
  const InsightsAcademicStandingCard({
    super.key,
    required this.student,
    required this.header,
  });

  final Student student;
  final String header;

  @override
  State<InsightsAcademicStandingCard> createState() =>
      _InsightsAcademicStandingCardState();
}

class _InsightsAcademicStandingCardState
    extends State<InsightsAcademicStandingCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 1200),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color(0xffF2F1EA),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.header,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Icon(
                    isExpanded
                        ? CupertinoIcons.chevron_down
                        : CupertinoIcons.right_chevron,
                    color: Colors.black,
                    size: 15),
              ],
            ),
            const VerticalSpacing(16),
            Text(
              giveAcademicInsights(widget.student),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            Visibility(
              visible: isExpanded,
              child: const SizedBox(height: 18),
            ),
            AnimatedCrossFade(
              firstChild: const Text('', style: TextStyle(fontSize: 0)),
              secondChild: Text(
                  'CLASS OF DEGRREE/RANGE OF CGPA\nFirst Class Honors/4.50 - 5.0\nSecond Class Honors(Upper Division)/3.50 - 4.49\nSecond Class Honors(Lower Division)/2.40 - 3.49\nThird Class Honors/1.50 - 2.39',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 1200),
              reverseDuration: Duration.zero,
              sizeCurve: Curves.fastLinearToSlowEaseIn,
            ),
            const VerticalSpacing(16),
          ],
        ),
      ),
    );
  }
}

String giveAcademicInsights(Student student) {
  final cgpa = calculateTotalStudentCGPA(student);
  switch (cgpa) {
    case >= 4.5:
       return "You're a first class student! You're doing so well";
    case >= 3.5:
      return "You're a second class student (upper division) You're almost there";
    case >= 2.4:
      return "You're a second class student (upper division) You're almost there";
    case >= 1.5:
      return "You're a second class student (upper division) You're almost there";
    case >= 1.0:
      return "You're a second class student (upper division) You're almost there";
    default:
    return "Input grades for insights";
  }


}