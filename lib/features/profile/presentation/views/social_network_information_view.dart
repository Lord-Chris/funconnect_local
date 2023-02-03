import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class SocialNetworkInformationView extends StatelessWidget {
  const SocialNetworkInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppText.aTSocialNetworkInformation,
                  style: AppTextStyles.medium20,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  AppText.aTOptional,
                  style: AppTextStyles.regular14
                      .copyWith(color: AppColors.locationIconAsh),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24.h,
                ),
                AppTextField(
                  onChanged: (val) {},
                  validator: (val) {
                    return null;
                  },
                  label: AppText.aTTwitter,
                  hint: AppText.aTTwitter,
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(
                      AppAssets.mention,
                      height: 17.h,
                    ),
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
                  label: AppText.aTInstagram,
                  hint: AppText.aTInstagram,
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(
                      AppAssets.mention,
                      height: 17.h,
                    ),
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
                  label: AppText.aTFacebook,
                  hint: AppText.aTFacebook,
                ),
                SizedBox(
                  height: 24.h,
                ),
                AppTextField(
                  onChanged: (val) {},
                  validator: (val) {
                    return null;
                  },
                  label: AppText.aTLinkedIn,
                  hint: AppText.aTLinkedIn,
                ),
                SizedBox(
                  height: 48.h,
                ),
              ],
            ),
          ),
        ),
        AppOrangeBtn(
          label: AppText.aTUpdateProfile,
          onTap: () =>
              context.read<EditProfileBloc>().add(UpdateProfileEvent()),
        ),
      ],
    );
  }
}
