import 'package:flutter/material.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/modules/dashboard/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'widgets/widgets.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xffFEFCF6),
        floatingActionButton: MaterialButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => AddYearBottomSheet());
            },
            color: const Color(0xffCAEEA3),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add),
                SizedBox(width: 8),
                Text('Add new'),
              ],
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.0512,
                  right: screenWidth * 0.0512,
                  top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacing(16),
                  DashboardAppbar(),
                  Hero(
                    tag: 'tag',
                    child: ValueListenableBuilder(
                        valueListenable:
                            Hive.box<Student>(studentBoxName).listenable(),
                        builder: (context, Box<Student> studentBox, _) {
                          final student = studentBox.getAt(0)!;
                          return DashboardCgpaCard(student: student);
                        }),
                  ),
                  const VerticalSpacing(20),
                  ValueListenableBuilder(
                      valueListenable:
                          Hive.box<Student>(studentBoxName).listenable(),
                      builder: (context, Box<Student> studentBox, _) {
                        final years = studentBox.getAt(0)!.years;
                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: List.generate(
                            years.length,
                            (index) => DashboardGridContainer(
                              year: years[index],
                              index: index,
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
