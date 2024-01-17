import 'package:flutter/material.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/utils/utility_functions.dart';
import 'package:grade_management_app/modules/dashboard/dashboard_page/year_result_page.dart';
import 'package:grade_management_app/modules/dashboard/models/models.dart';

class DashboardGridContainer extends StatelessWidget {
  final int index;
  final Year year;
  const DashboardGridContainer({
    required this.year,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => YearResultPage(index: index)));
      },
      child: Container(
        width: screenWidth * 0.425,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xff1B1C19),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( 
              year.name,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const VerticalSpacing(15),
            Text(
              'GPA: ${calculateGPAPerYear(year).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const VerticalSpacing(15),
            Text(
              'Units: ${calculateUnitsPerYear(year)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
