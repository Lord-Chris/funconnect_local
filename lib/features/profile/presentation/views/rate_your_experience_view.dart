import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class RateYourExperienceView extends StatelessWidget {
  const RateYourExperienceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 11,
          ),
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: Container(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            children: [
              Spacing.vertExtraMedium(),
              Text(
                'Rate your experience',
                style: AppTextStyles.medium24,
              ),
              Spacing.vertLarge(),
              AppNetworkImage(
                url: AppConstants.mockImage,
                isCircular: true,
                size: Size.fromRadius(54.r),
                fit: BoxFit.cover,
              ),
              Spacing.vertMedium(),
              Text(
                "John Doe",
                style: AppTextStyles.medium20,
              ),
              Spacing.vertRegular(),
              Text(
                "@johndoe@gmail.com",
                style: AppTextStyles.regular16.copyWith(
                  color: AppColors.secondary500,
                ),
              ),
              Spacing.vertLarge(),
              RatingBar(
                initialRating: 3,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: SvgPicture.asset(
                    AppAssets.ratingStarSvg,
                    height: 48,
                    width: 48,
                    colorFilter: const ColorFilter.mode(
                        AppColors.primary, BlendMode.srcIn),
                    fit: BoxFit.scaleDown,
                  ),
                  half: SvgPicture.asset(
                    AppAssets.ratingStarSvg,
                    height: 48,
                    width: 48,
                    colorFilter: const ColorFilter.mode(
                        AppColors.primary, BlendMode.srcIn),
                    fit: BoxFit.scaleDown,
                  ),
                  empty: SvgPicture.asset(
                    AppAssets.ratingStarSvg,
                    height: 48,
                    width: 48,
                    colorFilter: const ColorFilter.mode(
                        AppColors.wGreyE1, BlendMode.srcIn),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {},
              ),
              Spacing.vertMedium(),
              Text(
                'Don’t worry, this won’t be shared with anyone',
                style: AppTextStyles.regular12.copyWith(
                  color: AppColors.secondary500,
                ),
              ),
              Spacing.vertExtraMedium(),
              AppTextField(
                onChanged: (val) {},
                validator: (val) {
                  return null;
                },
                maxLines: 6,
                borderRadius: BorderRadius.circular(16.h),
                hint: AppText.aTWriteSomething,
              ),
              Spacing.vertExtraLarge(),
              AppButton(
                label: 'Rate our App',
                isCollapsed: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 88, vertical: 16),
                onTap: () {},
                labelColor: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
