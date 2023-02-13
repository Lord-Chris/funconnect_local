import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
<<<<<<< HEAD
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/core/presentation/widgets/app_auth_text_form_field.dart';
import 'package:funconnect/core/presentation/widgets/core_widgets.dart';
=======
>>>>>>> c3d8ec6e55619e09dae7806a4e654fbf7484ceaa
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/features/profile/presentation/views/widgets/interests_chip.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class OtherInformationView extends StatelessWidget {
  const OtherInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tags = [
      "Fine dining",
      "Arts & Culture",
      "Malls",
      "Karaoke",
      "Cozy spots",
      "Parks & Inn",
      "Lounge",
      "Wine labs",
      "Beach house"
    ];
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
<<<<<<< HEAD
              InkWell(onTap:()=>context
                  .read<EditProfileBloc>().add(ContinueTapEvent()),child: Text(AppText.aTSkip, style: AppTextStyles.regular16.copyWith(decoration: TextDecoration.underline),))
            ],
          ),
          Spacing.vertRegular(),
          AppTextForm(
            onChanged: (val) {},
            validator: (val) {
              return null;
            },
=======
              Text(
                AppText.aTSkip,
                style: AppTextStyles.regular16
                    .copyWith(decoration: TextDecoration.underline),
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          const AppTextField(
>>>>>>> c3d8ec6e55619e09dae7806a4e654fbf7484ceaa
            maxLines: 7,
            hint: AppText.aTWriteSomething,
          ),
<<<<<<< HEAD
          Spacing.vertExtraMedium(),
          Text(AppText.aTCurrentLocation, style: AppTextStyles.medium16
          ),
=======
          SizedBox(
            height: 32.h,
          ),
          Text(AppText.aTCurrentLocation, style: AppTextStyles.medium16),
>>>>>>> c3d8ec6e55619e09dae7806a4e654fbf7484ceaa
          Row(
            children: [
              Expanded(
                  child: Text(
                "67 Olumegbon road, Surulere",
                style: AppTextStyles.regular14
                    .copyWith(color: AppColors.locationIconAsh),
              )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    AppText.aTCheckMap,
                    style: AppTextStyles.regular14,
                  ))
            ],
          ),
<<<<<<< HEAD
          Align(alignment: Alignment.centerLeft,child: InkWell(onTap: (){}, child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(AppText.aTChange, style: AppTextStyles.regular14.copyWith(color: AppColors.primary),),
          ))),
          Spacing.vertExtraMedium(),
          Text(AppText.aTInterests, style: AppTextStyles.medium16
          ),
          Spacing.vertSmall(),
          Text(AppText.aTAddInterests, style: AppTextStyles.regular14.copyWith(color: AppColors.ash),),
          Spacing.vertSmall(),
=======
          Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      AppText.aTChange,
                      style: AppTextStyles.regular14
                          .copyWith(color: AppColors.primary),
                    ),
                  ))),
          SizedBox(
            height: 32.h,
          ),
          Text(AppText.aTInterests, style: AppTextStyles.medium16),
          SizedBox(
            height: 8.h,
          ),
          Text(
            AppText.aTAddInterests,
            style: AppTextStyles.regular14.copyWith(color: AppColors.ash),
          ),
          SizedBox(
            height: 8.h,
          ),
>>>>>>> c3d8ec6e55619e09dae7806a4e654fbf7484ceaa
          Wrap(
            spacing: 8.w,
            runSpacing: 12.h,
            children: [
              for (String title in tags)
                InterestsChip(title: title, onSelect: () {})
            ],
          ),
          Spacing.vertLarge(),
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
          Spacing.vertRegular(),
          Spacing.vertLarge(),
        ],
      ),
    );
  }
}
