import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/core/presentation/widgets/app_auth_text_form_field.dart';
import 'package:funconnect/core/presentation/widgets/app_orange_button.dart';
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/components/scrollable_column.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/presentation/widgets/app_text.dart';

class SocialNetworkInformationView extends StatelessWidget {
  const SocialNetworkInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
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
                AppTextForm(
                  onChanged: (val) {},
                  validator: (val) {
                    return null;
                  },
                  labelText: AppText.aTTwitter,
                  hintText: AppText.aTTwitter,
                  prefixIcon: Padding(
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
                AppTextForm(
                  onChanged: (val) {},
                  validator: (val) {
                    return null;
                  },
                  labelText: AppText.aTInstagram,
                  hintText: AppText.aTInstagram,
                  prefixIcon: Padding(
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
                AppTextForm(
                  onChanged: (val) {},
                  validator: (val) {
                    return null;
                  },
                  labelText: AppText.aTFacebook,
                  hintText: AppText.aTFacebook,
                ),
                SizedBox(
                  height: 24.h,
                ),
                AppTextForm(
                  onChanged: (val) {},
                  validator: (val) {
                    return null;
                  },
                  labelText: AppText.aTLinkedIn,
                  hintText: AppText.aTLinkedIn,
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
                context
                    .read<EditProfileBloc>().add(UpdateProfileEvent()),
        ),
      ],
    );
  }
}
