import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/components/app_network_image.dart';
import 'package:funconnect/shared/components/custom_button.dart';
import 'package:funconnect/shared/components/scrollable_column.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../places/presentation/widgets/home_categories_large_widget.dart';
import '../../../places/presentation/widgets/home_categories_widget.dart';

class EventDescriptionView extends StatelessWidget {
  final EventModel event;
  const EventDescriptionView({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: ScrollableColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppNetworkImage(
                        size: const Size.fromHeight(350),
                        url: event.cover,
                        borderRadius: 20,
                        fit: BoxFit.cover,
                      ),
                      Spacing.vertRegular(),
                      Text(
                        event.title,
                        style: AppTextStyles.semiBold24,
                      ),
                      Spacing.vertRegular(),
                      Row(
                        children: [
                          Container(
                            padding: REdgeInsets.fromLTRB(15, 6, 15, 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0.r),
                              border: Border.all(
                                width: 1,
                                color: AppColors.gray333,
                              ),
                            ),
                            child: Text(
                              event.type.capitalize(),
                              style: AppTextStyles.regular14.copyWith(
                                color: AppColors.gray97,
                              ),
                            ),
                          ),
                          Spacing.horizSmall(),
                          Container(
                            padding: REdgeInsets.fromLTRB(15, 6, 15, 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: AppColors.primary,
                            ),
                            child: Text(
                              double.tryParse(event.price)?.toString() ??
                                  "Free",
                              style: AppTextStyles.regular14.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacing.vertRegular(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const AppNetworkImage(
                          url: AppConstants.mockImage,
                          isCircular: true,
                          fit: BoxFit.cover,
                          size: Size.square(36),
                        ),
                        title: Text(
                          DumbAppStrings.eventDescriptionSubText0,
                          style: AppTextStyles.medium16,
                        ),
                        subtitle: Text(
                          DumbAppStrings.eventDescriptionSubText1,
                          style: AppTextStyles.regular14.copyWith(
                            color: AppColors.secondary500,
                          ),
                        ),
                      ),
                      Spacing.vertRegular(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppAssets.calenderSvg,
                            height: 18,
                          ),
                          Spacing.horizSmall(),
                          Spacing.horizTiny(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Saturday October 15th, 2022",
                                  style: AppTextStyles.regular14,
                                ),
                                Spacing.vertSmall(),
                                Text(
                                  "11:00 AM (GMT +1)",
                                  style: AppTextStyles.regular14,
                                ),
                                Spacing.vertSmall(),
                                Text(
                                  "Add to calender",
                                  style: AppTextStyles.semiBold14.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Spacing.vertRegular(),
                      Spacing.vertRegular(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 18,
                            color: AppColors.secondary500,
                          ),
                          Spacing.horizSmall(),
                          Spacing.horizTiny(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Freedom park, Lagos Island",
                                  style: AppTextStyles.regular14,
                                ),
                                Spacing.vertSmall(),
                                Spacing.vertSmall(),
                                Text(
                                  "Freedom park, Old hospital road, Lagos Island",
                                  style: AppTextStyles.regular14.copyWith(
                                    color: AppColors.secondary500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Spacing.vertRegular(),
                      Spacing.vertRegular(),
                      Text(
                        DumbAppStrings.eventDescriptionAboutText,
                        style: AppTextStyles.medium16,
                      ),
                      Spacing.vertTiny(),
                      Spacing.vertTiny(),
                      Text(
                        event.description,
                        style: AppTextStyles.regular14,
                      ),
                      Spacing.vertRegular(),
                      Spacing.vertRegular(),
                      Container(
                        height: 300.0.h,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.secondary800,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const AppNetworkImage(
                              url: AppConstants.mockImage,
                              isCircular: true,
                              fit: BoxFit.cover,
                              size: Size.square(56),
                            ),
                            Spacing.vertRegular(),
                            Text(
                              DumbAppStrings.eventDescriptionFirstEventText,
                              style: AppTextStyles.medium24,
                            ),
                            Spacing.vertRegular(),
                            Text(
                              DumbAppStrings.eventDescriptionSubText1,
                              style: AppTextStyles.regular16.copyWith(
                                color: AppColors.secondary400,
                              ),
                            ),
                            Text(
                              DumbAppStrings.eventDescriptionRsvpMailText,
                              style: AppTextStyles.medium16.copyWith(
                                color: AppColors.secondary200,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacing.vertRegular(),
                      Spacing.vertRegular(),
                      Spacing.vertRegular(),
                      Spacing.vertRegular(),
                      HomeViewCategoriesWidget(
                        label: DumbAppStrings.eventDescriptionMoreLikeText,
                        child: (index) {
                          final place = mockPlace;
                          return HomeCategoriesLargeWidget(
                            coverImage: place.coverImagePath,
                            name: place.name,
                            isBookmarked: place.isBookmarked,
                            rating: place.avgRating,
                            ratingCount: place.avgReviewCount,
                          );
                        },
                      ),
                      Spacing.vertRegular(),
                      Spacing.vertRegular(),
                      Spacing.vertRegular(),
                      Spacing.vertRegular(),
                      Spacing.vertRegular(),
                      Spacing.vertRegular(),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        "Free",
                        style: AppTextStyles.regular20.copyWith(
                          color: AppColors.gray1,
                        ),
                      ),
                      Spacing.horizRegular(),
                      Expanded(
                        child: AppButton(
                          label: "Request",
                          hasBorder: true,
                          buttonColor: AppColors.primary.withOpacity(.4),
                          borderColor: AppColors.primary.withOpacity(.4),
                          labelColor: AppColors.primary,
                          labelSize: 14,
                          onTap: () => locator<INavigationService>()
                              .toNamed(Routes.bookingRoute),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 100,
            child: ClipRect(
              child: Container(
                padding: const EdgeInsets.only(bottom: 5),
                color: AppColors.black.withOpacity(.7),
                alignment: Alignment.bottomCenter,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: locator<INavigationService>().back,
                        color: AppColors.black.withOpacity(0.5),
                        shape: const CircleBorder(),
                        minWidth: 30,
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 15,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          event.title,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBold24,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        color: AppColors.black.withOpacity(0.5),
                        shape: const CircleBorder(),
                        minWidth: 30,
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.more_vert,
                          size: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
