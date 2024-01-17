import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/utils/extensions.dart';
import 'package:grade_management_app/global/utils/utility_functions.dart';
import 'package:grade_management_app/modules/dashboard/insight_page/insights_academic_standing_card.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../dashboard_page/widgets/widgets.dart';
import '../models/models.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Student>(studentBoxName).listenable(),
        builder: (context, Box<Student> studentBox, _) {
          final student = studentBox.getAt(0)!;
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpacing(16),
                      DashboardAppbar(),
                      InsightsAcademicStandingCard(
                          header: 'Academic Standing:', student: student),
                      const VerticalSpacing(10),
                      InsightsEligbilityCard(
                          header: 'Graduation Eligibility', student: student),
                      const VerticalSpacing(10),
                      Container(
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color(0xffF2F1EA),
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'GPA Progression',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const VerticalSpacing(10),
                              LineDefault(years: student.years),
                            ],
                          )),
                      const VerticalSpacing(20)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}



class InsightsEligbilityCard extends StatefulWidget {
  const InsightsEligbilityCard({
    super.key,
    required this.student,
    required this.header,
  });

  final Student student;
  final String header;

  @override
  State<InsightsEligbilityCard> createState() => _InsightsEligbilityCardState();
}

class _InsightsEligbilityCardState extends State<InsightsEligbilityCard> {
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
      child: Container(
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
            Text(
              widget.header,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const VerticalSpacing(16),
            Text(
              giveEligibilityInsights(widget.student),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            const VerticalSpacing(16),
          ],
        ),
      ),
    );
  }
}



String giveEligibilityInsights(Student student) {
  final cgpa = calculateTotalStudentCGPA(student);
  
  

  if (cgpa >= 4.5) {
    return "You're definitely eligible for graduation";
  } else if (cgpa >= 3.5) {
    return "You're eligble for graduation";
  } else if (cgpa >= 2.5) {
    return "You're still eligible for graduation";
  } else if (cgpa >= 1.5) {
    return "Your graduation status is written in sand";
  } else if (cgpa >= 1.0) {
    return "You might not be graduating";
  } else {
    return "Input grades for insights";
  }
}

class LineDefault extends StatefulWidget {
  final List<Year> years;
  const LineDefault({required this.years, super.key});

  @override
  State<LineDefault> createState() => _LineDefaultState();
}

class _LineDefaultState extends State<LineDefault> {
  List<_ChartData>? chartData;
  // ignore: unused_field
  Timer? _timer;
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    _getChartData();

    _timer = Timer(const Duration(seconds: 1), () {
      setState(() {
        _getChartData();
      });
    });

    return _buildDefaultLineChart();
  }

  void _getChartData() {
    chartData = <_ChartData>[_ChartData(0,0)];
    int x = 1;
    
    for (Year year in widget.years) {
      for (Semester semester in year.semesters) {
        chartData!.add(_ChartData(x, calculateSemesterGPA(semester)));
        x++;
      }
    }
    chartData.log();
  }
                                                     
  /// Get the cartesian chart with default line series
  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      //  title: const ChartTitle(text:  'Title' ),
      legend: const Legend(
          isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 100,
          axisLabelFormatter: (axisLabelRenderArgs) => ChartAxisLabel('', null),
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          maximum: 5,
          interval: 0.5,
          numberFormat: NumberFormat('#.0'),
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          name: 'GPA',
          markerSettings: const MarkerSettings()),
    ];
  }

  @override
  void dispose() {
    _timer?.cancel();
    chartData!.clear();
    super.dispose();
  }
}

class _ChartData {
  _ChartData(
    this.x,
    this.y,
  );
  final int x;
  final double y;
}
