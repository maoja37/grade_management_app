import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grade_management_app/global/auth_service.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/utils/custom_input_border.dart';
import 'package:grade_management_app/global/widgets/bottom_sheet_notch.dart';
import 'package:grade_management_app/global/widgets/design_button.dart';
import 'package:iconsax/iconsax.dart';

class UpdateUsernameBottomSheet extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  UpdateUsernameBottomSheet({
    super.key,
  });

  final AuthService _authService = AuthService();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
                const VerticalSpacing(36),
                SvgPicture.asset('assets/oc-superhero.svg'),
                const VerticalSpacing(16),
                const Text(
                  'Update your name',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                const VerticalSpacing(32),
                TextFormField(
                  controller: _usernameController,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.length > 17) {
                      return 'Please enter a name less than 17 characters';
                    }
                    if (value.contains(' ')) {
                      return 'Please enter only First name ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter your name',
                    labelStyle: const TextStyle(color: Color(0xffABACA5)),
                    prefixIcon: const Icon(
                      Iconsax.messages,
                      size: 24,
                    ),
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
                const VerticalSpacing(29),
                DesignButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await _authService
                            .updateDisplayname(_usernameController.text)
                            .then((value) {
                          ScaffoldMessenger.of(formKey.currentState!.context)
                              .showSnackBar(const SnackBar(
                                  content:
                                      Text('Name Updated, Proceed to Login')));
                        }).catchError((error) {
                          ScaffoldMessenger.of(formKey.currentState!.context)
                              .showSnackBar(const SnackBar(
                                  content: Text('Error Updating Name')));
                          return null; // return null instead of ScaffoldFeatureController
                        }).whenComplete(() {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    text: 'Update Username'),
                const VerticalSpacing(24),
              ],
            )),
      ),
    );
  }
}
