import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/general_utils.dart';
import '../../../../shared/components/_components.dart';
import '../../../../shared/constants/_constants.dart';
import '../../domain/entities/review_model.dart';
import '../blocs/place_detail_bloc/place_detail_bloc.dart';
import '../blocs/place_detail_bloc/place_detail_event.dart';
import '../blocs/place_detail_bloc/place_detail_state.dart';

class ReviewSection extends HookWidget {
  const ReviewSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final newRating = useState(0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<PlaceDetailBloc, PlaceDetailState>(
          buildWhen: (_, current) => current is PlaceDetailIdleState,
          builder: (context, state) {
            if (state is! PlaceDetailIdleState) return const SizedBox();
            if (state.reviews.isEmpty) return const SizedBox();
            return Column(
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
                      "${state.reviewsData?.from} of ${state.reviewsData?.currentPage}",
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
            );
          },
        ),
        BlocBuilder<PlaceDetailBloc, PlaceDetailState>(
          buildWhen: (_, current) => current is PlaceDetailIdleState,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                      value: newRating.value.toDouble(),
                      onValueChanged: (val) {
                        newRating.value = val.toInt();
                      },
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
                HookBuilder(
                  builder: (context) {
                    useListenable(newRating);
                    useListenable(controller);
                    if (newRating.value > 0) {
                      return Row(
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
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Spacing.vertRegular(),
                HookBuilder(
                  builder: (context) {
                    useListenable(newRating);
                    useListenable(controller);
                    if (newRating.value > 0) {
                      return AppTextField(
                        maxLines: 4,
                        hint:
                            "Would you like to write anything about us? (optional)",
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.multiline,
                        controller: controller,
                        onEditingComplete: () {},
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                HookBuilder(
                  builder: (context) {
                    useListenable(newRating);
                    useListenable(controller);
                    if (newRating.value > 0) {
                      return Container(
                        padding: REdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.topRight,
                        child: AppButton(
                          label: "Send",
                          isCollapsed: true,
                          labelColor: AppColors.black,
                          borderRadius: 8,
                          padding: REdgeInsets.fromLTRB(40, 12, 40, 12),
                          onTap: () {
                            context.read<PlaceDetailBloc>().add(
                                  ReviewPlaceEvent(
                                      rating: newRating.value,
                                      comment: controller.text),
                                );
                            newRating.value = 0;
                            controller.clear();
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            );
          },
        ),
      ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppNetworkImage(
                url: review.user?.photoUrl ?? "",
                isCircular: true,
                fit: BoxFit.cover,
                size: const Size.fromRadius(19),
                placeholderAssetImage: AppAssets.fallbackUserProfileSvg,
              ),
              Spacing.horizTiny(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.user?.name ?? "",
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
              if (review.reviewedAt != null)
                Text(
                  GeneralUtils.parseTime(
                      DateTime.now().difference(review.reviewedAt!).inSeconds),
                  style: AppTextStyles.regular10.copyWith(
                    color: AppColors.gray97,
                  ),
                ),
            ],
          ),
          Spacing.vertRegular(),
          Text(
            review.comment,
            textAlign: TextAlign.start,
            style: AppTextStyles.regular14,
          ),
        ],
      ),
    );
  }
}
