import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/utils/custom_input_border.dart';
import 'package:grade_management_app/global/widgets/bottom_sheet_notch.dart';
import 'package:grade_management_app/global/widgets/design_button.dart';
import 'package:grade_management_app/modules/dashboard/models/models.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';

class AddCourseBottomSheet extends StatelessWidget {
  final int index;
  final int currentTab;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _courseUnitController = TextEditingController();
  AddCourseBottomSheet(
      {required this.index, required this.currentTab, super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffFEFCF6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const HorizontalSpacing(double.infinity),
                const VerticalSpacing(8),
                const BottomSheetNotch(),
                const VerticalSpacing(32),
                TextFormField(
                  controller: _courseNameController,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a course name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Course name',
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                    labelStyle: const TextStyle(color: Colors.black),
                    border: CustomOutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xffABACA5),
                      ),
                    ),
                    enabledBorder: CustomOutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xffABACA5),
                      ),
                    ),
                    focusedBorder: CustomOutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xffABACA5),
                      ),
                    ),
                  ),
                ),
                const VerticalSpacing(24),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _gradeController,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a grade';
                          }
                          if (value != RegExp(r'[A-F]').stringMatch(value)) {
                            return 'Please enter a valid grade';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Grade',
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 0, 10),
                          labelStyle: const TextStyle(color: Colors.black),
                          suffixIcon: const Icon(Iconsax.arrow_down_1),
                          border: CustomOutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xffABACA5),
                            ),
                          ),
                          enabledBorder: CustomOutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xffABACA5),
                            ),
                          ),
                          focusedBorder: CustomOutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xffABACA5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const HorizontalSpacing(16),
                    Expanded(
                      child: TextFormField(
                        controller: _courseUnitController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a unit';
                          }
                          if (value != RegExp(r'[0-9]').stringMatch(value)) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Unit',
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 0, 10),
                          labelStyle: const TextStyle(color: Colors.black),
                          suffixIcon: const Icon(Iconsax.arrow_down_1),
                          border: CustomOutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xffABACA5),
                            ),
                          ),
                          enabledBorder: CustomOutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xffABACA5),
                            ),
                          ),
                          focusedBorder: CustomOutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xffABACA5),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const VerticalSpacing(32),
                DesignButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final student =
                            Hive.box<Student>(studentBoxName).getAt(0);
                        final course = Course(
                            name: _courseNameController.text,
                            grade: _gradeController.text,
                            unit: int.parse(_courseUnitController.text));
                        if (currentTab == 0) {
                          student!.years[index].semesters[0].courses
                              .add(course);
                        } else {
                          student!.years[index].semesters[1].courses
                              .add(course);
                        }
                        Hive.box<Student>(studentBoxName).putAt(0, student);
                        Navigator.pop(context);
                        _courseNameController.clear();
                        _gradeController.clear();
                        _courseUnitController.clear();
                      }
                    },
                    text: 'Save'),
                const VerticalSpacing(32)
              ],
            )),
      ),
    );
  }
}
