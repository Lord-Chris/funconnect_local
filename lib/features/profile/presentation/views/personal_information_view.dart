import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class PersonalInformationView extends StatelessWidget {
  const PersonalInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            AppText.aTPersonalInformation,
            style: AppTextStyles.medium20,
          ),
          SizedBox(
            height: 48.h,
          ),
          DottedBorder(
            borderType: BorderType.Circle,
            padding: const EdgeInsets.all(8),
            color: AppColors.lightAsh,
            dashPattern: const [8, 6],
            strokeWidth: 1.6,
            strokeCap: StrokeCap.round,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 180.w,
                width: 180.w,
                decoration: const BoxDecoration(
                  color: AppColors.lightAsh,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: SvgPicture.asset(
                  AppAssets.addImageCamera,
                  height: 64,
                )),
              ),
            ),
          ),
          SizedBox(
            height: 48.h,
          ),
          AppTextField(
            onChanged: (val) {},
            validator: (val) {
              return null;
            },
            label: AppText.aTFullName,
            hint: AppText.aTFullName,
            prefix: Padding(
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
                style:
                    AppTextStyles.regular12.copyWith(color: AppColors.primary),
              )),
          SizedBox(
            height: 24.h,
          ),
          AppTextField(
            onChanged: (val) {},
            validator: (val) {
              return null;
            },
            label: AppText.aTUserName,
            hint: AppText.aTUserName,
            prefix: Padding(
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
                style:
                    AppTextStyles.regular12.copyWith(color: AppColors.primary),
              )),
          SizedBox(
            height: 24.h,
          ),
          AppTextField(
            onChanged: (val) {},
            validator: (val) {
              return null;
            },
            label: AppText.aTEmail,
            hint: AppText.aTEmail,
            prefix: Padding(
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
                style:
                    AppTextStyles.regular12.copyWith(color: AppColors.primary),
              )),
          SizedBox(
            height: 24.h,
          ),
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
          SizedBox(
            height: 24.h,
          ),
          AppTextField(
            onChanged: (val) {},
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
              ),
            ),
            suffix: SvgPicture.asset(
              AppAssets.arrowDown,
              width: 20,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          AppTextField(
            onChanged: (val) {},
            validator: (val) {
              return null;
            },
            label: AppText.aTMobileNumber,
            hint: AppText.aTMobileNumberHint,
            suffix: SvgPicture.asset(
              AppAssets.arrowDown,
              width: 20,
            ),
            prefix: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                AppAssets.phone,
                height: 17.h,
              ),
            ),
          ),
          SizedBox(
            height: 48.h,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                onTap: () =>
                    context.read<EditProfileBloc>().add(ContinueTapEvent()),
                label: AppText.aTContinue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                suffixWidget: SvgPicture.asset(
                  AppAssets.arrowRight,
                  width: 17,
                ),
                isCollapsed: true,
                labelColor: AppColors.black,
              )),
          SizedBox(
            height: 64.h,
          ),
        ],
      ),
    );
  }
}
