import 'dart:io';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_event.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_v2_bloc/home_v2_bloc.dart';
import 'package:funconnect/features/places/presentation/widgets/home_all_categories_list.dart';
import 'package:funconnect/features/places/presentation/widgets/home_all_interests_container.dart';
import 'package:funconnect/features/places/presentation/widgets/home_all_places_list.dart';

import 'package:funconnect/shared/constants/_constants.dart';

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
              child: context.watch<HomeV2Bloc>().userModel?.photoUrl == "" ||
                      context.watch<HomeV2Bloc>().userModel == null
                  ? SvgPicture.asset(
                      AppAssets.profileIconSvg,
                      height: 25.r,
                      width: 25.r,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    )
                  : FancyShimmerImage(
                      height: 50.r,
                      width: 50.r,
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
                      return Column(
                        children: [
                          state.interests.isNotEmpty
                              ? HomeAllInterestsContainer(
                                  interests: state.interests,
                                )
                              : const SizedBox(),
                          const Divider(
                            color: AppColors.secondary800,
                            height: 1,
                          ),
                          Spacing.vertSmall(),
                          HomeAllCategoriesList(state: state),
                          SizedBox(
                            height: 32.h,
                          ),
                          HomeAllPlacesList(state: state)
                        ],
                      );
                    }
                    if (state is HomeV2LoadingState) {
                      return Center(
                        child: SpinKitFadingCube(
                          color: AppColors.primary,
                          size: 50.r,
                        ),
                      );
                    }
                    return const SizedBox();
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
