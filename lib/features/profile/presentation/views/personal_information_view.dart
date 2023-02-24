import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';

import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:intl/intl.dart';

class PersonalInformationView extends StatelessWidget {
  const PersonalInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController dateOfBirthController = TextEditingController();
    TextEditingController mobileNumberController = TextEditingController();
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        ProfileModel profile = state.profile;
        fullNameController.text = state.profile.fullName;
        userNameController.text = state.profile.userName;
        emailController.text = state.profile.email;
        String? selectedGender = state.profile.gender.isEmpty?null:'${state.profile.gender[0].toUpperCase()}${state.profile.gender.substring(1).toLowerCase()}';
        dateOfBirthController.text = profile.dateOfBirth.isEmpty?"":DateFormat('dd/MM/yyyy').format(DateTime.parse(profile.dateOfBirth));
        mobileNumberController.text = state.profile.mobileNumber=='null'?'':state.profile.mobileNumber;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                AppText.aTPersonalInformation,
                style: AppTextStyles.medium20,
              ),
              Spacing.vertLarge(),
              DottedBorder(
                borderType: BorderType.Circle,
                padding: const EdgeInsets.all(8),
                color: AppColors.lightAsh,
                dashPattern: const [8, 6],
                strokeWidth: 1.6,
                strokeCap: StrokeCap.round,
                child: InkWell(
                  onTap: () =>
                      context.read<EditProfileBloc>().add(ImageTapEvent()),
                  child: Container(
                    height: 180.w,
                    width: 180.w,
                    decoration: const BoxDecoration(
                      color: AppColors.lightAsh,
                      shape: BoxShape.circle,
                    ),
                    child: profile.profileImageUrl == null
                        ? Center(
                            child: SvgPicture.asset(
                            AppAssets.addImageCamera,
                            height: 64,
                          ))
                        : profile.profileImageUrl!.startsWith("http")
                            ? ClipOval(
                                child: Image.network(
                                profile.profileImageUrl!,
                                height: 64,
                              ))
                            : ClipOval(
                              child: Image.file(
                              File(profile.profileImageUrl!),

                                ),
                            ),
                  ),
                ),
              ),
              Spacing.vertLarge(),
              AppTextField(
                onChanged: (val) {},
                validator: (val) {
                  return null;
                },
                label: AppText.aTFullName,
                hint: AppText.aTFullName,
                controller: fullNameController,
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    AppAssets.userProfile,
                    height: 17.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppText.aTChangeThis,
                    style: AppTextStyles.regular12
                        .copyWith(color: AppColors.primary),
                  )),
              Spacing.vertMedium(),
              AppTextField(
                onChanged: (val) {},
                validator: (val) {
                  return null;
                },
                label: AppText.aTUserName,
                hint: AppText.aTUserName,
                controller: userNameController,
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    AppAssets.userProfile,
                    height: 17.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppText.aTChangeThis,
                    style: AppTextStyles.regular12
                        .copyWith(color: AppColors.primary),
                  )),
              Spacing.vertMedium(),
              AppTextField(
                onChanged: (val) {},
                validator: (val) {
                  return null;
                },
                controller: emailController,
                label: AppText.aTEmail,
                hint: AppText.aTEmail,
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    AppAssets.mail,
                    height: 17.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppText.aTChangeThis,
                    style: AppTextStyles.regular12
                        .copyWith(color: AppColors.primary),
                  )),
              Spacing.vertMedium(),
              AppDropdownField<String>(
                label: "Gender",
                items: const ["Male", "Female"],
                prefix: SvgPicture.asset(
                  AppAssets.userProfile,
                  height: 17.h,
                  fit: BoxFit.scaleDown,
                ),
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    AppAssets.arrowDown,
                    width: 10,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                onChanged: (val) => context.read<EditProfileBloc>().add(EditProfileFieldsEvent(state.profile.copyWith(gender: val))),
                validator: context.validateNotEmpty,
                value: selectedGender,
              ),
              Spacing.vertMedium(),
              AppTextField(
                onChanged: (val) {},
                controller: dateOfBirthController,
                onTap: () async{
                  FocusScope.of(context).requestFocus(FocusNode());
                 DateTime? dateOfBirth = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1970),
                      lastDate: DateTime.now());

                 if(dateOfBirth!= null){
                    context.read<EditProfileBloc>().add(EditProfileFieldsEvent(state.profile.copyWith(dateOfBirth: dateOfBirth.toIso8601String())));
                 }
                },
                validator: (val) {
                  return null;
                },
                label: AppText.aTDateOfBirth,
                hint: AppText.aTDateOfBirthHint,
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    AppAssets.calendar,
                    height: 17.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                suffix: SvgPicture.asset(
                  AppAssets.arrowDown,
                  width: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Spacing.vertMedium(),
              AppTextField(
                onChanged: (val) {},
                validator: (val) {
                  return null;
                },
                label: AppText.aTMobileNumber,
                hint: AppText.aTMobileNumberHint,
                controller: mobileNumberController,
                suffix: SvgPicture.asset(
                  AppAssets.arrowDown,
                  width: 20,
                  fit: BoxFit.scaleDown,
                ),
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    AppAssets.phone,
                    height: 17.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Spacing.vertLarge(),
              Align(
                  alignment: Alignment.centerRight,
                  child: AppButton(
                    onTap: () {
                      context.read<EditProfileBloc>().add(EditProfileFieldsEvent(state.profile.copyWith(userName: userNameController.text,fullName:  fullNameController.text, gender: selectedGender, email: emailController.text, mobileNumber: mobileNumberController.text)));
                          context.read<EditProfileBloc>().add(
                              ContinueTapEvent());
                    },
                    label: AppText.aTContinue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    suffixWidget: SvgPicture.asset(
                      AppAssets.arrowRight,
                      width: 17,
                      fit: BoxFit.scaleDown,
                    ),
                    isCollapsed: true,
                    labelColor: AppColors.black,
                  )),
              Spacing.vertRegular(),
              Spacing.vertLarge(),
            ],
          ),
        );
      },
    );
  }
}
