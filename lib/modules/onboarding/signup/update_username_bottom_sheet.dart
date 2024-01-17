import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grade_management_app/global/constants/spacing.dart';
import 'package:grade_management_app/global/services/auth_service.dart';
import 'package:grade_management_app/global/utils/custom_input_border.dart';
import 'package:grade_management_app/global/utils/extensions.dart';
import 'package:grade_management_app/global/widgets/bottom_sheet_notch.dart';
import 'package:grade_management_app/global/widgets/custom_toast.dart';
import 'package:grade_management_app/global/widgets/design_button.dart';
import 'package:iconsax/iconsax.dart';

class UpdateUsernameBottomSheet extends StatefulWidget {

  const UpdateUsernameBottomSheet({
    super.key,
  });

  @override
  State<UpdateUsernameBottomSheet> createState() => _UpdateUsernameBottomSheetState();
}

class _UpdateUsernameBottomSheetState extends State<UpdateUsernameBottomSheet> {
  bool isLoading = false;
  late TextEditingController _usernameController ;



  final AuthService _authService = AuthService();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _usernameController = TextEditingController();
    super.initState();
  }

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
                  loading: isLoading,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await _authService
                            .updateDisplayName(_usernameController.text)
                            .then((value) {
                          context.showToast(
                              message: 'Name Updated, Proceed to Login');
                        }).catchError((error) {
                          setState(() {
                            isLoading = false;
                          });
                          context.showToast(
                              message: 'Error Updating Name',
                              backgroundColor: const Color(0xffFCEEEE),
                              textColor: const Color(0xffEA0000));
                         
                          return null; // return null instead of ScaffoldFeatureController
                        }).whenComplete(() {
                          setState(() {
                            isLoading = false;
                            'update username when complete'.log();
                          });
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
