import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/domain/params/add_friends.dart';
import 'package:funconnect/features/plans/domain/usecases/add_plan_friends_usecase.dart';
import 'package:funconnect/shared/components/custom_button.dart';
import 'package:funconnect/shared/constants/colors.dart';

class AddPlanFriendDialog extends StatefulWidget {
  final MiniPlanModel plan;
  const AddPlanFriendDialog({super.key, required this.plan});

  @override
  State<AddPlanFriendDialog> createState() => _AddPlanFriendDialogState();
}

class _AddPlanFriendDialogState extends State<AddPlanFriendDialog> {
  final _friendsEmailFormKey = GlobalKey<FormState>();
  final _friendEmailController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36.r),
            color: isDarkMode ? const Color(0xff161616) : AppColors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
            child: isLoading
                ? const Wrap(
                    children: [Center(child: CircularProgressIndicator())])
                : //TODO: Add loading state
                Column(mainAxisSize: MainAxisSize.min, children: [
                    Text("Add friend to plan",
                        style: TextStyle(
                            color:
                                isDarkMode ? AppColors.white : AppColors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xff202020)
                            : const Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8.0),
                        child: Form(
                          key: _friendsEmailFormKey,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _friendEmailController,
                                  validator: (value) {
                                    if (value == null) {
                                      return "Please enter an email";
                                    }
                                    if (value.isEmpty) {
                                      return "Please enter an email";
                                    }
                                    if (EmailValidator.validate(value) ==
                                        false) {
                                      return "Please enter a valid email";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 8, top: 16, bottom: 16),
                                    fillColor: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xff202020)
                                        : const Color(0xFFF1F1F1),
                                    hintText: "Add a Friend's email",
                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? const Color(0xff999999)
                                          : AppColors.secondary600,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    AppButton(
                      label: "Save",
                      labelColor: Colors.white,
                      onTap: () async {
                        if (_friendsEmailFormKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await AddFriendUseCase().call(AddFriendsParams(
                              email: _friendEmailController.text,
                              miniPlanId: widget.plan.id));
                          Navigator.pop(context, true);
                        }
                      },
                      borderRadius: 8,
                      buttonColor: AppColors.primary,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    AppButton(
                      label: "Cancel",
                      labelColor: Colors.white,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: 8,
                      buttonColor: const Color(0xff202020),
                    ),
                  ]),
          ),
        ));
  }
}
