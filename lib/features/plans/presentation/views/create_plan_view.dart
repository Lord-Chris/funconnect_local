import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/presentation/blocs/create_plan_bloc/create_plan_bloc.dart';
import 'package:funconnect/features/plans/presentation/components/friend_icon_widget.dart';
import 'package:funconnect/shared/components/custom_button.dart';

import 'package:funconnect/shared/constants/colors.dart';

class CreatePlanView extends StatefulWidget {
  const CreatePlanView({super.key});

  @override
  State<CreatePlanView> createState() => _CreatePlanViewState();
}

class _CreatePlanViewState extends State<CreatePlanView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _planNameController = TextEditingController();
  final TextEditingController _planDescriptionController =
      TextEditingController();
  final TextEditingController _friendEmailController = TextEditingController();
  final _friendsEmailFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _planNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create a  plan",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: _planNameController,
                  validator: (value) {
                    if (value == null) {
                      return "Please enter a plan name";
                    }
                    if (value.isEmpty) {
                      return "Please enter a  plan name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.all(16),
                    fillColor: const Color(0xff202020),
                    hintText: "What's the title of the plan...",
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xff999999),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text("Description",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Please enter a  plan description";
                    }
                    if (value.isEmpty) {
                      return "Please enter a  plan description";
                    }
                    return null;
                  },
                  controller: _planDescriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.all(16),
                    fillColor: const Color(0xff202020),
                    hintText: "Describe the plan...",
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xff999999),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "Add friends",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff202020),
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
                                if (EmailValidator.validate(value) == false) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 8, top: 16, bottom: 16),
                                fillColor: const Color(0xff202020),
                                hintText: "Add a Friend's email",
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xff999999),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_friendsEmailFormKey.currentState!
                                  .validate()) {
                                context.read<CreatePlanBloc>().add(
                                    AddFriendEvent(
                                        _friendEmailController.text.trim()));
                                _friendEmailController.clear();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.gray333,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                BlocBuilder<CreatePlanBloc, CreatePlanState>(
                  builder: (context, state) {
                    if (state is FriendAddedState) {
                      return SizedBox(
                          height: 65.h,
                          width: double.infinity,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return FriendIconWidget(
                                  email: state.friendsEmails[index],
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 8.w,
                                  ),
                              itemCount: state.friendsEmails.length));
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reminder",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          DropdownButtonFormField2(
                              isExpanded: true,
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.zero,
                              ),
                              alignment: Alignment.centerLeft,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8),
                                filled: true,
                                fillColor: const Color(0xff202020),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              items: ReminderType.values
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.value),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                context
                                    .read<CreatePlanBloc>()
                                    .add(ChangeReminderTypeEvent(value!));
                              },
                              value: ReminderType.values[0],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff999999),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notification",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          DropdownButtonFormField2<String>(
                              isExpanded: true,
                              alignment: Alignment.centerLeft,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8),
                                filled: true,
                                fillColor: const Color(0xff202020),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(child: Text("Google")),
                              ],
                              onChanged: (value) {
                                context.read<CreatePlanBloc>().add(
                                    const ChangeReminderMediumEvent(
                                        ReminderMedium.google));
                              },
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff999999),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                AppButton(
                    label: "Create Plan",
                    borderRadius: 8,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<CreatePlanBloc>()
                            .add(CreatePlanClickedEvent(
                              planName: _planNameController.text.trim(),
                              planDescription:
                                  _planDescriptionController.text.trim(),
                            ));
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
