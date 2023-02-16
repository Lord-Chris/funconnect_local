import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';

import 'package:funconnect/core/presentation/widgets/app_auth_text_form_field.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:intl/intl.dart';

class PersonalInformationView extends StatelessWidget {
  const PersonalInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController dateOfBirthController = TextEditingController();
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        ProfileModel profile = state.profile;
        dateOfBirthController.text = profile.dateOfBirth.isEmpty?"":DateFormat('dd/MM/yyyy').format(DateTime.parse(profile.dateOfBirth));
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
              AppTextForm(
                onChanged: (val) {},
                validator: (val) {
                  return null;
                },
                labelText: AppText.aTFullName,
                hintText: AppText.aTFullName,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    AppAssets.userProfile,
                    height: 17.h,
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
              AppTextForm(
                onChanged: (val) {},
                validator: (val) {
                  return null;
                },
                labelText: AppText.aTUserName,
                hintText: AppText.aTUserName,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    AppAssets.userProfile,
                    height: 17.h,
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
              AppTextForm(
                onChanged: (val) {},
                validator: (val) {
                  return null;
                },
                labelText: AppText.aTEmail,
                hintText: AppText.aTEmail,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    AppAssets.mail,
                    height: 17.h,
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
                onChanged: (val) {},
                validator: context.validateNotEmpty,
                value: null,
              ),
              Spacing.vertMedium(),
              AppTextForm(
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
                labelText: AppText.aTDateOfBirth,
                hintText: AppText.aTDateOfBirthHint,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    AppAssets.calendar,
                    height: 17.h,
                  ),
                ),
                suffixIcon: SvgPicture.asset(
                  AppAssets.arrowDown,
                  width: 20,
                ),
              ),
              Spacing.vertMedium(),
              AppTextForm(
                onChanged: (val) {},
                validator: (val) {
                  return null;
                },
                labelText: AppText.aTMobileNumber,
                hintText: AppText.aTMobileNumberHint,
                suffixIcon: SvgPicture.asset(
                  AppAssets.arrowDown,
                  width: 20,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    AppAssets.phone,
                    height: 17.h,
                  ),
                ),
              ),
              Spacing.vertLarge(),
              Align(
                  alignment: Alignment.centerRight,
                  child: AppButton(
                    onTap: () =>
                        context.read<EditProfileBloc>().add(ContinueTapEvent()),
                    label: AppText.aTContinue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    suffixWidget: SvgPicture.asset(
                      AppAssets.arrowRight,
                      width: 17,
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
