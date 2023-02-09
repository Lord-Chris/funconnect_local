import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/features/places/presentation/widgets/home_categories_large_widget.dart';
import 'package:funconnect/features/places/presentation/widgets/home_categories_widget.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:readmore/readmore.dart';

class PlaceDetailView extends StatelessWidget {
  const PlaceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AppNetworkImage(
                  size: Size.fromHeight(409.h),
                  url: AppConstants.mockImage,
                  borderRadius: 20,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 16,
                  child: SafeArea(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.black.withOpacity(.6),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 20.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacing.vertRegular(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Leisure mall",
                          style: AppTextStyles.medium24,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1),
                        child: SvgPicture.asset(
                          AppAssets.uploadSvg,
                          color: AppColors.white,
                          height: 20,
                        ),
                      ),
                      Spacing.horizMedium(),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1),
                        child: SvgPicture.asset(
                          AppAssets.bookmarkIconSvg,
                          color: AppColors.white,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                  Spacing.vertTiny(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "4.8",
                        style: AppTextStyles.regular16,
                      ),
                      Spacing.horizExtraTiny(),
                      Flexible(
                        child: FittedBox(
                          child: RatingStars(
                            value: 3,
                            onValueChanged: (v) {},
                            starBuilder: (index, color) => Icon(
                              Icons.star,
                              color: color,
                              size: 14,
                            ),
                            starSize: 14,
                            starCount: 5,
                            starSpacing: 0,
                            maxValue: 5,
                            maxValueVisibility: false,
                            valueLabelVisibility: false,
                            animationDuration:
                                const Duration(milliseconds: 1000),
                            starOffColor: AppColors.white,
                            starColor: AppColors.primary,
                          ),
                        ),
                      ),
                      Spacing.horizTiny(),
                      Text(
                        "(3.2k)",
                        style: AppTextStyles.regular16,
                      ),
                    ],
                  ),
                  Spacing.vertMedium(),
                  Text(
                    "About",
                    style: AppTextStyles.medium16,
                  ),
                  Spacing.vertSmall(),
                  ReadMoreText(
                    'The mall house has numerous retail stores and outlets offering different types of products and services such as garments, food and beverages, electronics, and everything that is required in our day-to-day lives under a single roof. Hundreds of',
                    trimLines: 4,
                    colorClickableText: AppColors.primary,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: '',
                    style: AppTextStyles.regular14,
                    moreStyle: AppTextStyles.regular14.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  Spacing.vertRegular(),
                  Text(
                    "Features",
                    style: AppTextStyles.medium16,
                  ),
                  Spacing.vertSmall(),
                  ReadMoreText(
                    'The mall house has numerous retail stores and outlets offering different types of products and services such as garments, food and beverages, electronics, and everything that is required in our day-to-day lives under a single roof. Hundreds of',
                    trimLines: 4,
                    colorClickableText: AppColors.primary,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: '',
                    style: AppTextStyles.regular14,
                    moreStyle: AppTextStyles.regular14.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  Spacing.vertMedium(),
                  _buildTile(
                    Icons.location_on,
                    "Umudege Ezinifite Road, Igbo-Ukwu, Aguata LGA, Anambra",
                  ),
                  Spacing.vertSmall(),
                  _buildTile(
                    Icons.timer,
                    "9:00 AM - 5:00 PM",
                  ),
                  Spacing.vertSmall(),
                  _buildTile(
                    CupertinoIcons.phone_fill,
                    "070 5458 7779",
                  ),
                  Spacing.vertMedium(),
                  Container(
                    padding: REdgeInsets.fromLTRB(20, 10, 20, 10),
                    color: AppColors.secondary800,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppAssets.bookRideSvg,
                        ),
                        Spacing.horizSmall(),
                        Text(
                          "Book a ride",
                          style: AppTextStyles.regular16,
                        ),
                      ],
                    ),
                  ),
                  Spacing.vertMedium(),
                  Spacing.vertSmall(),
                  Text(
                    "Ratings & Reviews",
                    style: AppTextStyles.regular14,
                  ),
                  Spacing.vertSmall(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "4 of 50",
                        style: AppTextStyles.regular12.copyWith(
                          color: AppColors.gray97,
                        ),
                      ),
                      DropdownButton<String>(
                        value: "Sorted by most helpful",
                        alignment: Alignment.center,
                        items: ["Sorted by most helpful"]
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: AppTextStyles.regular12.copyWith(
                                      color: AppColors.gray97,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (val) {},
                        underline: Container(),
                        isDense: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.gray97,
                          size: 15.sp,
                        ),
                        style: AppTextStyles.regular12.copyWith(
                          color: AppColors.gray97,
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return const _ReviewItem();
                    },
                  ),
                  Spacing.vertRegular(),
                  Spacing.vertSmall(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tap to rate",
                        style: AppTextStyles.regular14.copyWith(
                          color: AppColors.gray97,
                        ),
                      ),
                      RatingStars(
                        value: 2,
                        onValueChanged: (v) {},
                        starBuilder: (index, color) {
                          if (color == AppColors.primary) {
                            return Icon(
                              Icons.star_rounded,
                              color: color,
                              size: 14,
                            );
                          }
                          return Icon(
                            Icons.star_border_rounded,
                            color: color,
                            size: 14,
                          );
                        },
                        starSize: 14,
                        starCount: 5,
                        starSpacing: 0,
                        maxValue: 5,
                        maxValueVisibility: false,
                        valueLabelVisibility: false,
                        animationDuration: const Duration(milliseconds: 1000),
                        starOffColor: AppColors.white.withOpacity(.7),
                        starColor: AppColors.primary,
                      ),
                    ],
                  ),
                  Spacing.vertSmall(),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.reviewSvg,
                        height: 17.sp,
                      ),
                      Spacing.horizSmall(),
                      Text(
                        "Write a review",
                        style: AppTextStyles.medium12,
                      ),
                    ],
                  ),
                  Spacing.vertRegular(),
                  const AppTextField(
                    maxLines: 4,
                    hint: "Would you like to write anything about us?",
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  Spacing.vertMedium(),
                  const HomeViewCategoriesWidget(
                    label: "More like this",
                    child: HomeCategoriesLargeWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        Spacing.horizSmall(),
        Spacing.horizTiny(),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.regular14.copyWith(height: 1.5),
          ),
        ),
      ],
    );
  }
}

class _ReviewItem extends StatelessWidget {
  const _ReviewItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.fromLTRB(16, 18, 16, 18),
      margin: REdgeInsets.fromLTRB(0, 8, 0, 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke, width: .2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const AppNetworkImage(
                url: AppConstants.mockImage,
                isCircular: true,
                fit: BoxFit.cover,
                size: Size.fromRadius(19),
              ),
              Spacing.horizTiny(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tamara Jackson",
                      style: AppTextStyles.dynamic(
                        10,
                        weight: FontWeight.w500,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          RatingStars(
                            value: 3,
                            onValueChanged: (v) {},
                            starBuilder: (index, color) => Icon(
                              Icons.star,
                              color: color,
                              size: 9,
                            ),
                            starSize: 9,
                            starCount: 5,
                            starSpacing: 0,
                            maxValue: 5,
                            maxValueVisibility: false,
                            valueLabelVisibility: false,
                            animationDuration:
                                const Duration(milliseconds: 1000),
                            starOffColor: AppColors.white,
                            starColor: AppColors.primary,
                          ),
                          Spacing.horizExtraTiny(),
                          Text(
                            "4.8",
                            style: AppTextStyles.regular10.copyWith(
                              color: AppColors.gray97,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "2 days ago",
                style: AppTextStyles.regular10.copyWith(
                  color: AppColors.gray97,
                ),
              ),
            ],
          ),
          Spacing.vertRegular(),
          Text(
            "The place is an amazing space. My 3 kids had a lovely time, oh please don’t use the lift on the down floor it is broken. Real nice staffs, saw the swing rolls, did chareoke and I must say this is a must visit for everyone in Lagos. we can talk all day about what",
            style: AppTextStyles.regular14,
          ),
        ],
      ),
    );
  }
}
