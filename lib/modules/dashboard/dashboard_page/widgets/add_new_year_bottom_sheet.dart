import 'package:flutter/material.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/widgets/bottom_sheet_notch.dart';
import 'package:grade_management_app/modules/dashboard/models/models.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';

class AddYearBottomSheet extends StatelessWidget {
  final TextEditingController _yearController = TextEditingController();
  AddYearBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              const VerticalSpacing(20),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(
                  hintText: '  Add another year',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  suffixIcon: InkWell(
                    onTap: () {
                      if (_yearController.text.isNotEmpty) {
                        final student =
                            Hive.box<Student>(studentBoxName).getAt(0);
                        student!.years.add(Year(name: _yearController.text));
                        Hive.box<Student>(studentBoxName).putAt(0, student);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Icon(
                      Iconsax.arrow_up_35,
                      color: Color(0xff777772),
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 0,
                    minHeight: 20,
                  ),
                ),
              ),
              const VerticalSpacing(29)
            ],
          )),
    );
  }
}
