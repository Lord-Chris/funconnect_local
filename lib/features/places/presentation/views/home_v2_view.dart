import 'dart:io';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_event.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_v2_bloc/home_v2_bloc.dart';
import 'package:funconnect/features/places/presentation/widgets/home_all_categories_list.dart';
import 'package:funconnect/features/places/presentation/widgets/home_all_places_list.dart';

import 'package:funconnect/shared/constants/_constants.dart';
import 'package:shimmer/shimmer.dart';

class HomeV2View extends StatelessWidget {
  const HomeV2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        leading: InkWell(
          onTap: () => context
              .read<DashboardBloc>()
              .add(TabTapEvent(!Platform.isIOS ? 4 : 3)),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Center(
              child: context.watch<HomeV2Bloc>().userModel?.photoUrl == null
                  ? SvgPicture.asset(
                      AppAssets.profileIconSvg,
                      height: 25.r,
                      width: 25.r,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    )
                  : FancyShimmerImage(
                      height: 25.r,
                      width: 25.r,
                      boxFit: BoxFit.cover,
                      shimmerBaseColor: AppColors.primary,
                      shimmerHighlightColor: AppColors.white,
                      boxDecoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      imageUrl:
                          context.watch<HomeV2Bloc>().userModel?.photoUrl ?? "",
                      imageBuilder: (context, imageProvider) {
                        return CircleAvatar(
                            radius: 25.r, backgroundImage: imageProvider);
                      },
                      errorWidget: SvgPicture.asset(
                        AppAssets.profileIconSvg,
                        height: 25.r,
                        width: 25.r,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                      ),
                    ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Hi ${context.watch<HomeV2Bloc>().userModel?.username ?? ""}",
              style: AppTextStyles.medium20,
            ),
            Spacing.vertTiny(),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.locationIconAsh,
                  size: 13,
                ),
                Flexible(
                  child: Text(
                    context.watch<HomeV2Bloc>().appLocation?.parsedAddress ??
                        "",
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.secondary400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<HomeV2Bloc>().add(NotificationTapEvent());
            },
            icon: Badge(
              isLabelVisible:
                  context.watch<NotificationBloc>().state.showNotificationBadge,
              smallSize: 10,
              textColor: AppColors.white,
              child: const Icon(
                CupertinoIcons.bell_fill,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
        child: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            context.read<HomeV2Bloc>().add(HomeV2InitEvent());
            return;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Spacing.vertSmall(),
                const Divider(
                  color: AppColors.secondary800,
                  height: 1,
                ),
                BlocBuilder<HomeV2Bloc, HomeV2State>(
                  builder: (context, state) {
                    if (state is HomeV2LoadedState) {
                      return SizedBox(
                        height: 50,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Spacing.horizTiny();
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: state.interests.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: AppColors.interestWidgetAsh,
                              ),
                              child: Row(
                                children: [
                                  FancyShimmerImage(
                                    height: 20.r,
                                    width: 20.r,
                                    boxFit: BoxFit.cover,
                                    shimmerBaseColor: AppColors.primary,
                                    shimmerHighlightColor: AppColors.white,
                                    boxDecoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    imageUrl: state.interests[index].coverPhoto,
                                    imageBuilder: (context, imageProvider) {
                                      return CircleAvatar(
                                          radius: 20.r,
                                          backgroundImage: imageProvider);
                                    },
                                    errorWidget: SvgPicture.asset(
                                      AppAssets.profileIconSvg,
                                      height: 25.r,
                                      width: 25.r,
                                      colorFilter: const ColorFilter.mode(
                                          Colors.white, BlendMode.srcIn),
                                    ),
                                  ),
                                  Spacing.horizSmall(),
                                  Text(
                                    state.interests[index].name,
                                    maxLines: 1,
                                    style: AppTextStyles.regular12,
                                  ),
                                  Spacing.horizTiny(),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const Divider(
                  color: AppColors.secondary800,
                  height: 1,
                ),
                Spacing.vertSmall(),
                BlocBuilder<HomeV2Bloc, HomeV2State>(
                  builder: (context, state) {
                    if (state is HomeV2LoadedState) {
                      return HomeAllCategoriesList(state: state);
                    }
                    if (state is HomeV2LoadingState) {
                      return SizedBox(
                        width: 200.0,
                        height: 100.0,
                        child: Shimmer.fromColors(
                            baseColor: AppColors.primary,
                            highlightColor: Colors.white,
                            child: Text(
                              "Fun Connecting....",
                              style: AppTextStyles.medium20,
                            )),
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 32.h,
                ),
                BlocBuilder<HomeV2Bloc, HomeV2State>(
                  builder: (context, state) {
                    if (state is HomeV2LoadedState) {
                      return HomeAllPlacesList(state: state);
                    }
                    if (state is HomeV2LoadingState) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ));
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
