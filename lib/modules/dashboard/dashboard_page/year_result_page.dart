import 'package:flutter/material.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/modules/dashboard/dashboard_page/widgets/widgets.dart';
import 'package:grade_management_app/modules/dashboard/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';

class YearResultPage extends StatefulWidget {
  final int index;
  const YearResultPage({required this.index, super.key});

  @override
  State<YearResultPage> createState() => _YearResultPageState();
}

class _YearResultPageState extends State<YearResultPage>
    with SingleTickerProviderStateMixin {
  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'First Semester'),
    Tab(text: 'Second Semester'),
  ];
  late TabController _tabController;
  late AddCourseBottomSheet _addCourseBottomSheet;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: _tabs.length,
      initialIndex: 0,
    );
    _addCourseBottomSheet = AddCourseBottomSheet(
        index: widget.index, currentTab: _tabController.index);
    _tabController.addListener(() {
      setState(() {
        _addCourseBottomSheet = AddCourseBottomSheet(
          index: widget.index,
          currentTab: _tabController.index,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFEFCF6),
      floatingActionButton: MaterialButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => _addCourseBottomSheet);
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const VerticalSpacing(24),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.arrow_left),
                    HorizontalSpacing(8),
                    Text(
                      'Back',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              const VerticalSpacing(26),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xffE6E6E6),
                  borderRadius: BorderRadius.circular(90),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                  indicatorWeight: 10,
                  labelPadding: const EdgeInsets.only(top: 10),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: const Color(0xffCAEEA3),
                  ),
                  onTap: (index) {
                    _tabController.animateTo(index);
                  },
                  enableFeedback: true,
                  tabs: _tabs
                      .map(
                        (e) => Container(
                          width: MediaQuery.of(context).size.width /
                              2, // Half the width for each tab
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                90), // Set the border radius for each tab
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            e.text!,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    FirstSemesterTabView(index: widget.index),
                    SecondSemesterTabView(index: widget.index),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstSemesterTabView extends StatelessWidget {
  final int index;
  const FirstSemesterTabView({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
              valueListenable: Hive.box<Student>(studentBoxName).listenable(),
              builder: (context, Box<Student> studentBox, _) {
                final semester = studentBox.getAt(0)!.years[index].semesters[0];
                return DashboardGpaCard(semester: semester);
              }),
          const Text(
            'Courses',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const VerticalSpacing(12),
          ValueListenableBuilder(
              valueListenable: Hive.box<Student>(studentBoxName).listenable(),
              builder: (context, Box<Student> studentBox, _) {
                final courses =
                    studentBox.getAt(0)!.years[index].semesters[0].courses;
                return Wrap(
                    runSpacing: 8,
                    children: List.generate(
                        courses.length,
                        (index) => CourseTile(
                              course: courses[index],
                            )));
              }),
        ],
      ),
    );
  }
}

class SecondSemesterTabView extends StatelessWidget {
  final int index;
  const SecondSemesterTabView({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
              valueListenable: Hive.box<Student>(studentBoxName).listenable(),
              builder: (context, Box<Student> studentBox, _) {
                final semester = studentBox.getAt(0)!.years[index].semesters[1];
                return DashboardGpaCard(semester: semester);
              }),
          const Text(
            'Courses',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const VerticalSpacing(12),
          ValueListenableBuilder(
              valueListenable: Hive.box<Student>(studentBoxName).listenable(),
              builder: (context, Box<Student> studentBox, _) {
                final courses =
                    studentBox.getAt(0)!.years[index].semesters[1].courses;
                return Wrap(
                    runSpacing: 8,
                    children: List.generate(
                        courses.length,
                        (index) => CourseTile(
                              course: courses[index],
                            )));
              }),
        ],
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  final Course course;
  const CourseTile({
    required this.course,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(
          0xffDEE6CE,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const VerticalSpacing(9),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Grade: ${course.grade}'),
                  const HorizontalSpacing(16),
                  Text('Credit: ${course.unit}'),
                ],
              )
            ],
          ),
          Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xffC7E9E6),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Row(
                children: [
                  Text('Edit'),
                  HorizontalSpacing(8),
                  Icon(
                    Iconsax.edit_2,
                    size: 16,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
