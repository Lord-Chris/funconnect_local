import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/core/utils/general_utils.dart';
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
import 'package:story_view/story_view.dart';

import '../../../saved/presentation/blocs/saved_bloc.dart';
import '../../../saved/presentation/blocs/saved_event.dart';

class PlaceDetailView extends HookWidget {
  final PlaceModel place;
  const PlaceDetailView({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = StoryController();
    useEffect(() {
      context.read<PlaceDetailBloc>().add(PlaceInitEvent(place));
      return () => controller.dispose();
    }, []);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final bloc = context.read<PlaceDetailBloc>();
          bloc.add(PlaceInitEvent(place));
          await bloc.stream.first;
        },
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox.fromSize(
                      size: Size.fromHeight(409.h),
                      child: Builder(
                        builder: (context) {
                          final state = context.watch<PlaceDetailBloc>().state;
                          if (state is PlaceDetailIdleState) {
                            if (state.place.images.length > 1) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: StoryView(
                                  controller: controller,
                                  indicatorColor: AppColors.primary,
                                  repeat: true,
                                  inline: true,
                                  storyItems: [
                                    ...state.place.images.map(
                                      (e) => StoryItem(
                                        AppNetworkImage(
                                          cacheImage: false,
                                          size: Size.fromHeight(409.h),
                                          url: e.path,
                                          borderRadius: 20,
                                          errorAssetImage:
                                              AppAssets.placesPlaceHolderSvg,
                                          fit: BoxFit.cover,
                                        ),
                                        duration: const Duration(seconds: 7),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            if (state.place.images.isNotEmpty) {
                              return AppNetworkImage(
                                url: state.place.images[0].path,
                                errorWidget: AppNetworkImage(
                                  url: place.coverImagePath,
                                  borderRadius: 20,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: 20,
                                fit: BoxFit.cover,
                              );
                            }
                          }
                          return AppNetworkImage(
                            url: place.coverImagePath,
                            borderRadius: 20,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    Spacing.vertRegular(),
                    _InfoSection(place: place),
                    const _ReviewSection(),
                    Spacing.vertMedium(),
                    const _MorePlacesSection(),
                  ],
                ),
              ),
              Positioned(
                left: 23.w,
                top: 23,
                child: SafeArea(
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: AppColors.black.withOpacity(.6),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 20.r,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MorePlacesSection extends StatelessWidget {
  const _MorePlacesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceDetailBloc, PlaceDetailState>(
      buildWhen: (_, current) => current is PlaceDetailIdleState,
      builder: (context, state) {
        if (state is! PlaceDetailIdleState) return const SizedBox();
        if (state.place.similarPlaces.isEmpty) return const SizedBox();
        return HomeSection<PlaceModel>(
          label: "More like this",
          children: state.place.similarPlaces.map((e) => e).toList(),
          widget: (PlaceModel place) {
            return HomeCategoriesLargeWidget(
              showRatings: place.showRatings,
              coverImage: place.coverImagePath,
              name: place.name,
              isBookmarked: place.isBookmarked,
              rating: place.avgRating,
              ratingCount: place.avgReviewCount,
              onTap: () => context.read<PlaceDetailBloc>().add(
                    PlaceTapEvent(place: place),
                  ),
            );
          },
        );
      },
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
      // buildWhen: (_, current) => current is PlaceDetailIdleState,
      builder: (context, state) {
        if (state is PlaceDetailFetchingState ||
            state is PlaceDetailFailureState) {
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
                  InkWell(
                    onTap: () => context
                        .read<PlaceDetailBloc>()
                        .add(ShareTapEvent(place)),
                    child: SvgPicture.asset(
                      AppAssets.uploadSvg,
                      colorFilter: const ColorFilter.mode(
                          AppColors.white, BlendMode.srcIn),
                      height: 20,
                    ),
                  ),
                  Spacing.horizMedium(),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1),
                    child: InkWell(
                      onTap: () async {
                        final bloc =
                            context.read<PlaceDetailBloc>().stream.first;
                        context.read<PlaceDetailBloc>().add(BookmarkTapEvent());
                        await bloc;

                        // ignore: use_build_context_synchronously
                        context.read<SavedBloc>().add(
                            const GetAllUserSavedPlaces(showLoader: false));
                      },
                      child: SvgPicture.asset(
                        place.isBookmarked
                            ? AppAssets.savedIconSvg
                            : AppAssets.bookmarkIconSvg,
                        colorFilter: ColorFilter.mode(
                          place.isBookmarked
                              ? AppColors.primary
                              : AppColors.white,
                          BlendMode.srcIn,
                        ),
                        height: 20,
                      ),
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
              if (state is PlaceDetailFetchingState)
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
                InkWell(
                  onTap: () =>
                      context.read<PlaceDetailBloc>().add(ShareTapEvent(place)),
                  child: SvgPicture.asset(
                    AppAssets.uploadSvg,
                    colorFilter: const ColorFilter.mode(
                        AppColors.white, BlendMode.srcIn),
                    height: 20,
                  ),
                ),
                Spacing.horizMedium(),
                Builder(builder: (context) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 1),
                    child: InkWell(
                      onTap: () async {
                        final bloc =
                            context.read<PlaceDetailBloc>().stream.first;
                        context.read<PlaceDetailBloc>().add(BookmarkTapEvent());
                        await bloc;

                        // ignore: use_build_context_synchronously
                        // context.read<SavedBloc>().add(
                        //     const GetAllUserSavedPlaces(showLoader: false));
                      },
                      child: SvgPicture.asset(
                        state.place.isBookmarked
                            ? AppAssets.savedIconSvg
                            : AppAssets.bookmarkIconSvg,
                        colorFilter: ColorFilter.mode(
                          state.place.isBookmarked
                              ? AppColors.primary
                              : AppColors.white,
                          BlendMode.srcIn,
                        ),
                        height: 20,
                      ),
                    ),
                  );
                }),
              ],
            ),
            Spacing.vertTiny(),
            place.showRatings > 0
                ? Row(
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
                            value: state.place.reviewsAvgRating ??
                                state.place.avgRating,
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
                        "(${state.place.reviewsCount.toInt()})",
                        style: AppTextStyles.regular16,
                      ),
                    ],
                  )
                : const SizedBox(),
            Spacing.vertMedium(),
            Text(
              "About",
              style: AppTextStyles.medium16,
            ),
            Spacing.vertSmall(),

            /** 
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
            */
            Html(
              data: state.place.description,
              style: {
                "body": Style(
                  margin: Margins(
                    bottom: Margin.zero(),
                    left: Margin.zero(),
                    top: Margin.zero(),
                    right: Margin.zero(),
                  ),
                )
              },
              onLinkTap: (
                url,
                context,
                attributes,
              ) {
                GeneralUtils.openUrl(Uri.parse(url ?? ""));
              },
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
            Spacing.vertRegular(),
            Spacing.vertSmall(),
            if (state.place.location?.address != null)
              _buildTile(
                  Icons.location_on,
                  state.place.location!.address,
                  () => context
                      .read<PlaceDetailBloc>()
                      .add(AddressTapEvent(location: state.place.location!))),
            _buildTile(
              Icons.timer,
              "${state.place.opensAtParsed.format(context)} - ${state.place.closesAtParsed.format(context)}",
            ),
            _buildTile(
              CupertinoIcons.phone_fill,
              state.place.phoneE164,
              () => context
                  .read<PlaceDetailBloc>()
                  .add(PhoneTapEvent(phone: state.place.phoneE164)),
            ),
            if (state.place.emailAddress.isNotEmpty)
              _buildTile(
                CupertinoIcons.mail,
                state.place.emailAddress,
              ),
            if (!Platform.isIOS) ...[
              Spacing.vertSmall(),
              Spacing.vertRegular(),
              InkWell(
                onTap: () =>
                    context.read<PlaceDetailBloc>().add(BookRideEvent()),
                child: Container(
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
              ),
            ],
            Spacing.vertMedium(),
          ],
        );
      },
    );
  }

  Widget _buildTile(IconData icon, String label, [VoidCallback? onTap]) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 4.r),
        child: Row(
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
        ),
      ),
    );
  }
}

class _ReviewSection extends HookWidget {
  const _ReviewSection({
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
              const AppNetworkImage(
                url: "",
                isCircular: true,
                fit: BoxFit.cover,
                size: Size.fromRadius(19),
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
