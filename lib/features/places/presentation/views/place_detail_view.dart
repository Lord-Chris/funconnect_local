import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_event.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_state.dart';
import 'package:funconnect/features/places/presentation/widgets/home_categories_large_widget.dart';
import 'package:funconnect/features/places/presentation/widgets/home_categories_widget.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:readmore/readmore.dart';

class PlaceDetailView extends HookWidget {
  final PlaceModel place;
  const PlaceDetailView({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<PlaceDetailBloc>().add(PlaceInitEvent(place));
      return null;
    }, []);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AppNetworkImage(
                  size: Size.fromHeight(409.h),
                  url: place.coverImagePath,
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
                  _InfoSection(place: place),
                  const _ReviewSection(),
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
                  HomeViewCategoriesWidget(
                    label: "More like this",
                    child: (index) {
                      final place = mockPlace;
                      return HomeCategoriesLargeWidget(
                        coverImage: place.coverImagePath,
                        name: place.name,
                        isBookmarked: false,
                        rating: place.avgRating,
                        ratingCount: place.avgReviewCount,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final PlaceModel place;
  const _InfoSection({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceDetailBloc, PlaceDetailState>(
      buildWhen: (_, current) => current is PlaceDetailIdleState,
      builder: (context, state) {
        if (state is PlaceDetailFetchingState) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      place.name,
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
                    place.avgRating.toString(),
                    style: AppTextStyles.regular16,
                  ),
                  Spacing.horizExtraTiny(),
                  Flexible(
                    child: FittedBox(
                      child: RatingStars(
                        value: place.avgRating,
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
                        animationDuration: const Duration(milliseconds: 1000),
                        starOffColor: AppColors.white,
                        starColor: AppColors.primary,
                      ),
                    ),
                  ),
                  Spacing.horizTiny(),
                  Text(
                    "(${place.avgReviewCount})",
                    style: AppTextStyles.regular16,
                  ),
                ],
              ),
              Spacing.vertMedium(),
              const Center(
                child: AppLoader(
                  color: AppColors.primary,
                ),
              ),
            ],
          );
        }
        if (state is! PlaceDetailIdleState) return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    state.place.name,
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
                  state.place.reviewsAvgRating?.toStringAsFixed(1) ??
                      state.place.avgRating.toString(),
                  style: AppTextStyles.regular16,
                ),
                Spacing.horizExtraTiny(),
                Flexible(
                  child: FittedBox(
                    child: RatingStars(
                      value:
                          state.place.reviewsAvgRating ?? state.place.avgRating,
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
                      animationDuration: const Duration(milliseconds: 1000),
                      starOffColor: AppColors.white,
                      starColor: AppColors.primary,
                    ),
                  ),
                ),
                Spacing.horizTiny(),
                Text(
                  "(${state.place.reviewsCount.toInt()})",
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
              state.place.description,
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
            if (state.place.features.isNotEmpty) Spacing.vertRegular(),
            if (state.place.features.isNotEmpty)
              Text(
                "Features",
                style: AppTextStyles.medium16,
              ),
            if (state.place.features.isNotEmpty) Spacing.vertSmall(),
            if (state.place.features.isNotEmpty)
              ReadMoreText(
                state.place.features
                    .map((e) => "● ${e.name.capitalize()}")
                    .join("\n"),
                trimLines: 4,
                colorClickableText: AppColors.primary,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Read more',
                trimExpandedText: '',
                style: AppTextStyles.regular14.copyWith(
                  height: 1.5,
                ),
                moreStyle: AppTextStyles.regular14.copyWith(
                  color: AppColors.primary,
                ),
              ),
            Spacing.vertMedium(),
            _buildTile(
              Icons.location_on,
              state.place.location.address,
            ),
            Spacing.vertSmall(),
            _buildTile(
              Icons.timer,
              "${state.place.opensAtParsed.format(context)} - ${state.place.closesAtParsed.format(context)}",
            ),
            Spacing.vertSmall(),
            _buildTile(
              CupertinoIcons.phone_fill,
              state.place.phoneE164,
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
          ],
        );
      },
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

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceDetailBloc, PlaceDetailState>(
      buildWhen: (_, current) => current is PlaceDetailIdleState,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state is PlaceDetailIdleState)
              if (state.reviews.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                      itemCount: state.reviews.length,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _ReviewItem(
                          review: state.reviews[index],
                        );
                      },
                    ),
                    Spacing.vertRegular(),
                  ],
                ),
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
          ],
        );
      },
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final ReviewModel review;
  const _ReviewItem({
    Key? key,
    required this.review,
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
                            value: review.rating.toDouble(),
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
                            review.rating.toString(),
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
            review.comment,
            style: AppTextStyles.regular14,
          ),
        ],
      ),
    );
  }
}
