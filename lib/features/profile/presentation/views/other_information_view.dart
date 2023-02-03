import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/core/presentation/widgets/app_auth_text_form_field.dart';
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/features/profile/presentation/views/widgets/interests_chip.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/components/scrollable_column.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/presentation/widgets/app_text.dart';

class OtherInformationView extends StatelessWidget {
  const OtherInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tags = ["Fine dining","Arts & Culture", "Malls","Karaoke", "Cozy spots", "Parks & Inn" , "Lounge", "Wine labs", "Beach house"];
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppText.aTOtherInformation,
            style: AppTextStyles.medium20,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              Text(AppText.aTAddBio, style: AppTextStyles.regular16),
              Spacer(),
              Text(AppText.aTSkip, style: AppTextStyles.regular16.copyWith(decoration: TextDecoration.underline),)
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          AppTextForm(
            onChanged: (val) {},
            validator: (val) {
              return null;
            },
            maxLines: 7,
            hintText: AppText.aTWriteSomething,
          ),
          SizedBox(
            height: 32.h,
          ),
          Text(AppText.aTCurrentLocation, style: AppTextStyles.medium16
          ),
          Row(
            children: [
              Expanded(child: Text("67 Olumegbon road, Surulere", style: AppTextStyles.regular14.copyWith(color: AppColors.locationIconAsh),)),
              TextButton(onPressed: (){}, child: Text(AppText.aTCheckMap, style: AppTextStyles.regular14,))
            ],
          ),
          Align(alignment: Alignment.centerLeft,child: InkWell(onTap: (){}, child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(AppText.aTChange, style: AppTextStyles.regular14.copyWith(color: AppColors.primary),),
          ))),
          SizedBox(
            height: 32.h,
          ),
          Text(AppText.aTInterests, style: AppTextStyles.medium16
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(AppText.aTAddInterests, style: AppTextStyles.regular14.copyWith(color: AppColors.ash),),
          SizedBox(
            height: 8.h,
          ),
          Wrap(
            spacing: 8.w,
            runSpacing: 12.h,
            children: [
              for(String title in tags)
                InterestsChip(title: title, onSelect: (){

                })

            ],
          ),
          SizedBox(
            height: 48.h,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                onTap: () =>
                    context
                        .read<EditProfileBloc>().add(ContinueTapEvent()),
                label: AppText.aTContinue,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
