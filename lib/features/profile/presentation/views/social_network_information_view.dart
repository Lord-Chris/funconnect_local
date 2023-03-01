import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class SocialNetworkInformationView extends StatelessWidget {
  const SocialNetworkInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        ProfileModel userProfile = state.profile;
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
                      label: AppText.aTTwitter,
                      hint: AppText.aTTwitter,
                      onChanged: (val) => context.read<EditProfileBloc>().add(
                          EditProfileFieldsEvent(
                              state.profile.copyWith(twitterHandle: val))),
                      validator: (val) {
                        return null;
                      },
                      initialValue: userProfile.twitterHandle,
                      prefix: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: SvgPicture.asset(
                          AppAssets.mention,
                          height: 20.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    AppTextField(
                      label: AppText.aTInstagram,
                      hint: AppText.aTInstagram,
                      onChanged: (val) => context.read<EditProfileBloc>().add(
                          EditProfileFieldsEvent(
                              state.profile.copyWith(instagramHandle: val))),
                      validator: (val) {
                        return null;
                      },
                      initialValue: userProfile.instagramHandle,
                      prefix: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: SvgPicture.asset(
                          AppAssets.mention,
                          height: 20.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    AppTextField(
                      label: AppText.aTFacebook,
                      hint: AppText.aTFacebook,
                      onChanged: (val) => context.read<EditProfileBloc>().add(
                          EditProfileFieldsEvent(
                              state.profile.copyWith(facebookHandle: val))),
                      validator: (val) {
                        return null;
                      },
                      initialValue: userProfile.facebookHandle,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    AppTextField(
                      label: AppText.aTLinkedIn,
                      hint: AppText.aTLinkedIn,
                      onChanged: (val) => context.read<EditProfileBloc>().add(
                          EditProfileFieldsEvent(
                              state.profile.copyWith(linkedInHandle: val))),
                      validator: (val) {
                        return null;
                      },
                      initialValue: userProfile.linkedInHandle,
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
              isBusy: state.isUpdatingProfile,
              onTap: () {
                context.read<EditProfileBloc>().add(UpdateProfileEvent());
              },
            ),
          ],
        );
      },
    );
  }
}
