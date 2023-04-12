import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/models/_models.dart';

class OtherInformationView extends StatelessWidget {
  const OtherInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<String> tags = [
    //   "Fine dining",
    //   "Arts & Culture",
    //   "Malls",
    //   "Karaoke",
    //   "Cozy spots",
    //   "Parks & Inn",
    //   "Lounge",
    //   "Wine labs",
    //   "Beach house"
    // ];
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        UserModel userProfile = state.profile;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppText.aTOtherInformation,
                style: AppTextStyles.medium20,
                textAlign: TextAlign.center,
              ),
              Spacing.vertRegular(),
              Row(
                children: [
                  Text(AppText.aTAddBio, style: AppTextStyles.regular16),
                  const Spacer(),
                  InkWell(
                      onTap: () => context
                          .read<EditProfileBloc>()
                          .add(ContinueTapEvent()),
                      child: Text(
                        AppText.aTSkip,
                        style: AppTextStyles.regular16
                            .copyWith(decoration: TextDecoration.underline),
                      ))
                ],
              ),
              Spacing.vertRegular(),
              AppTextField(
                onChanged: (val) => context.read<EditProfileBloc>().add(
                    EditProfileFieldsEvent(state.profile.copyWith(bio: val))),
                textCapitalization: TextCapitalization.sentences,
                initialValue: userProfile.bio,
                maxLines: 7,
                hint: AppText.aTWriteSomething,
              ),
              Spacing.vertExtraMedium(),
              Text(AppText.aTCurrentLocation, style: AppTextStyles.medium16),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    userProfile.location?.address ?? '',
                    style: AppTextStyles.regular14
                        .copyWith(color: AppColors.locationIconAsh),
                  )),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       AppText.aTCheckMap,
                  //       style: AppTextStyles.regular14,
                  //     ))
                ],
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                      onTap: () => context
                          .read<EditProfileBloc>()
                          .add(UpdateLocationTapEvent()),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          AppText.aTChange,
                          style: AppTextStyles.regular14
                              .copyWith(color: AppColors.primary),
                        ),
                      ))),
              Spacing.vertExtraMedium(),
              /*Text(AppText.aTInterests, style: AppTextStyles.medium16),
          Spacing.vertSmall(),
          Text(
            AppText.aTAddInterests,
            style: AppTextStyles.regular14.copyWith(color: AppColors.ash),
          ),
          Spacing.vertSmall(),
          Wrap(
            spacing: 8.w,
            runSpacing: 12.h,
            children: [
              for (String title in tags)
                InterestsChip(title: title, onSelect: () {})
            ],
          ),*/
              Spacing.vertLarge(),
              Align(
                  alignment: Alignment.centerRight,
                  child: AppButton(
                    onTap: () {
                      context.read<EditProfileBloc>().add(ContinueTapEvent());
                    },
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
