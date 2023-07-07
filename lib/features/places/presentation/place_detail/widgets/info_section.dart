import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:readmore/readmore.dart';

import '../../../../../core/utils/general_utils.dart';
import '../../../../../shared/components/_components.dart';
import '../../../../../shared/constants/_constants.dart';
import '../../../domain/entities/place_model.dart';
import '../bloc/place_detail_bloc.dart';
import '../bloc/place_detail_event.dart';
import '../bloc/place_detail_state.dart';

class InfoSection extends StatelessWidget {
  final PlaceModel place;
  const InfoSection({
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
        padding: REdgeInsets.symmetric(vertical: 4),
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
