import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_v2_bloc/home_v2_bloc.dart';
import 'package:funconnect/features/places/presentation/widgets/home_categories_comtainer.dart';
import 'package:funconnect/features/places/presentation/widgets/home_places_comtainer.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:shimmer/shimmer.dart';

class HomeV2View extends StatelessWidget {
  const HomeV2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        leading: Center(
            child: FancyShimmerImage(
                imageUrl: context.watch<HomeV2Bloc>().userModel?.photoUrl ?? "",
                imageBuilder: (context, imageProvider) {
                  return CircleAvatar(
                      radius: 25.r, backgroundImage: imageProvider);
                },
                errorWidget: SvgPicture.asset(
                  AppAssets.profileIconSvg,
                  height: 25.r,
                  width: 25.r,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ))),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Hi ${context.watch<HomeV2Bloc>().userModel?.name}",
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
            onPressed: () {},
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
        padding: const EdgeInsets.only(left: 16.0),
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
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 32.h,
                      );
                    },
                    shrinkWrap: true,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index1) {
                      return SizedBox(
                        height: 200.h,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.categories[index1].name,
                                    style: AppTextStyles.medium20,
                                  ),
                                  Text(
                                    "See All",
                                    style: AppTextStyles.medium20,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Expanded(
                              child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: 8.w,
                                    );
                                  },
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      state.categories[index1].data.length,
                                  itemBuilder: (context, index) {
                                    return HomeCategoryContainer(
                                        category: state
                                            .categories[index1].data[index]);
                                  }),
                            ),
                          ],
                        ),
                      );
                    },
                  );
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
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 32.h,
                      );
                    },
                    shrinkWrap: true,
                    itemCount: state.places.length,
                    itemBuilder: (context, index1) {
                      return SizedBox(
                        height: 200.h,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(state.places[index1].name,
                                      style: AppTextStyles.medium20),
                                  Text(
                                    "See All",
                                    style: AppTextStyles.medium20,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Expanded(
                              child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: 8.w,
                                    );
                                  },
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.places[index1].data.length,
                                  itemBuilder: (context, index) {
                                    return HomePlaceContainer(
                                        place:
                                            state.places[index1].data[index]);
                                  }),
                            ),
                          ],
                        ),
                      );
                    },
                  );
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
      )),
    );
  }
}
