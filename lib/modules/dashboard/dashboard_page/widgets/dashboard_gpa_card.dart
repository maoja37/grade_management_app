import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/utils.dart';
import 'package:grade_management_app/modules/dashboard/models/models.dart';

class DashboardGpaCard extends StatelessWidget {
  const DashboardGpaCard({
    required this.semester,
    super.key,
  });

  final Semester semester;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: const EdgeInsets.only(top: 16, bottom: 24),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xffCAEEA3),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'CGPA',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const VerticalSpacing(16),
              Text(
                calculateSemesterGPA(semester).toStringAsFixed(2),
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
              ),
              const VerticalSpacing(16),
              Text(
                'Total units: ${calculateTotalUnitsPerSemester(semester)}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              )
            ],
          ),
          SvgPicture.asset('assets/oc-hand-holding-papers.svg')
        ],
      ),
    );
  }
}
