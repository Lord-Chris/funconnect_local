import 'dart:io';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/extensions/string_extension.dart';
import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/core/utils/general_utils.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_places_data.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_v2_bloc/place_detail_v2_bloc.dart';
import 'package:funconnect/features/places/presentation/widgets/home_categories_large_widget.dart';
import 'package:funconnect/features/places/presentation/widgets/home_categories_widget.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../domain/entities/place_model.dart';

class PlaceDetailViewCopy extends StatelessWidget {
  final HomePlacesData place;
  const PlaceDetailViewCopy({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<PlaceDetailV2Bloc, PlaceDetailV2State>(
            builder: (context, state) {
              if (state is PlaceDetailsLoaded) {
                return SingleChildScrollView(
                  child: Column(children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 409.h,
                              width: double.infinity,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: PageView.builder(
                                controller: pageController,
                                itemCount: state.place.images.length,
                                itemBuilder: (context, index) {
                                  return FancyShimmerImage(
                                    imageUrl: state.place.images[index].path,
                                    boxFit: BoxFit.cover,
                                    shimmerBaseColor: AppColors.primary,
                                    shimmerHighlightColor: Colors.white,
                                    shimmerBackColor: Colors.white,
                                    errorWidget:
                                        Image.network(place.coverImagePath),
                                  );
                                },
                              ),
                            ),
                            Spacing.vertRegular(),
                            SmoothPageIndicator(
                              controller: pageController,
                              count: state.place.images.length,
                              effect: ExpandingDotsEffect(
                                  dotColor: AppColors.primary,
                                  activeDotColor: AppColors.primary,
                                  dotHeight: 8.h,
                                  dotWidth: 8.w,
                                  expansionFactor: 2,
                                  spacing: 4),
                            ),
                            Spacing.vertRegular(),
                            _InfoSection(place: state.place),
                            _ReviewSection(
                              place: state.place,
                              reviewModel: state.reviewsData,
                            ),
                            Spacing.vertMedium(),
                            _MorePlacesSection(place: state.place),
                          ],
                        ),
                        Positioned(
                          left: 23.w,
                          top: 23,
                          child: SafeArea(
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: CircleAvatar(
                                radius: 18.r,
                                backgroundColor:
                                    AppColors.black.withOpacity(.6),
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
                    )
                  ]),
                );
              }
              if (state is PlaceDetailLoadingState) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Hero(
                          transitionOnUserGestures: true,
                          tag: place.id,
                          child: Container(
                            height: 409.h,
                            width: double.infinity,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: FancyShimmerImage(
                              imageUrl: place.coverImagePath,
                              boxFit: BoxFit.cover,
                              shimmerBaseColor: AppColors.primary,
                              shimmerHighlightColor: Colors.white,
                              shimmerBackColor: Colors.white,
                            ),
                          ),
                        ),
                        Spacing.vertRegular(),
                        Shimmer.fromColors(
                            baseColor: AppColors.primary,
                            highlightColor: Colors.white,
                            child: Text(
                              "Loading ${place.name} Details...",
                              style: AppTextStyles.medium20,
                            )),
                      ],
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
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final FullPlaceModel place;
  const _InfoSection({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
                  .read<PlaceDetailV2Bloc>()
                  .add(const PlaceDetailShareTapEvent()),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  AppAssets.uploadSvg,
                  colorFilter:
                      const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                  height: 20,
                ),
              ),
            ),
            Spacing.horizMedium(),
            Builder(builder: (context) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 1),
                child: InkWell(
                  onTap: () async {
                    context
                        .read<PlaceDetailV2Bloc>()
                        .add(PlaceDetailBookmarkTapEvent(place));

                    // ignore: use_build_context_synchronously
                    // context.read<SavedBloc>().add(
                    //     const GetAllUserSavedPlaces(showLoader: false));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
              );
            }),
          ],
        ),
        Spacing.vertTiny(),
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
          data: place.description,
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
        if (place.features.isNotEmpty) Spacing.vertRegular(),
        if (place.features.isNotEmpty)
          Text(
            "Features",
            style: AppTextStyles.medium16,
          ),
        if (place.features.isNotEmpty) Spacing.vertSmall(),
        if (place.features.isNotEmpty)
          ReadMoreText(
            place.features.map((e) => "● ${e.name.capitalize()}").join("\n"),
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
        if (place.location?.address != null)
          _buildTile(
            Icons.location_on,
            place.location!.address,
            /*
                  () => context
                      .read<PlaceDetailBloc>()
                      .add(AddressTapEvent(location: state.place.location!))),
                      */
          ),
        _buildTile(
          Icons.timer,
          "${place.opensAtParsed.format(context)} - ${place.closesAtParsed.format(context)}",
        ),
        _buildTile(
          CupertinoIcons.phone_fill,
          place.phoneE164,
          /*
              () => context
                  .read<PlaceDetailBloc>()
                  .add(PhoneTapEvent(phone: state.place.phoneE164)),
                  */
        ),
        if (place.emailAddress.isNotEmpty)
          _buildTile(
            CupertinoIcons.mail,
            place.emailAddress,
          ),
        if (!Platform.isIOS) ...[
          Spacing.vertSmall(),
          Spacing.vertRegular(),
          InkWell(
            /*
                onTap: () =>
                    context.read<PlaceDetailBloc>().add(BookRideEvent()),
                    */
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
  final PaginatedData<ReviewModel> reviewModel;
  final FullPlaceModel place;
  const _ReviewSection({
    required this.reviewModel,
    required this.place,
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
        Spacing.vertSmall(),
        Visibility(
          visible: place.reviewsCount > 0,
          child: Column(
            children: [
              Spacing.vertSmall(),
              Text(
                "Ratings & Reviews",
                style: AppTextStyles.regular14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${reviewModel.from} of ${reviewModel.currentPage}",
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
                itemCount: place.reviewsCount.toInt(),
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _ReviewItem(
                    review: reviewModel.data[index],
                  );
                },
              ),
              Spacing.vertRegular(),
            ],
          ),
        ),
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
                hint: "Would you like to write anything about us? (optional)",
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
                    /*
                            context.read<PlaceDetailBloc>().add(
                                  ReviewPlaceEvent(
                                      rating: newRating.value,
                                      comment: controller.text),
                                );

                                
                            newRating.value = 0;
                            controller.clear();

                            */
                  },
                ),
              );
            }
            return const SizedBox();
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

class _MorePlacesSection extends StatelessWidget {
  final FullPlaceModel place;
  const _MorePlacesSection({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeSection<PlaceModel>(
      label: "More like this",
      children: place.similarPlaces.map((e) => e).toList(),
      widget: (PlaceModel place) {
        return HomeCategoriesLargeWidget(
            showRatings: place.showRatings,
            coverImage: place.coverImagePath,
            name: place.name,
            isBookmarked: place.isBookmarked,
            rating: place.avgRating,
            ratingCount: place.avgReviewCount,
            onTap: () {}
            /*
              () => context.read<PlaceDetailBloc>().add(
                    PlaceTapEvent(place: place),
                  ),
                  */
            );
      },
    );
  }
}
