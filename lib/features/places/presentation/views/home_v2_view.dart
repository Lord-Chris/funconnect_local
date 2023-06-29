import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_v2_bloc/home_v2_bloc.dart';
import 'package:funconnect/features/places/presentation/widgets/home_categories_comtainer.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class HomeV2View extends StatelessWidget {
  const HomeV2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        leading: Center(
            child: CachedNetworkImage(
          imageUrl: context.watch<HomeV2Bloc>().userModel?.photoUrl ?? "",
          imageBuilder: (context, imageProvider) {
            return CircleAvatar(radius: 25.r, backgroundImage: imageProvider);
          },
          errorWidget: (context, url, error) {
            return CircleAvatar(
                radius: 25.r,
                backgroundImage: Image.asset(AppAssets.userProfile).image);
          },
        )),
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
          child: Column(
        children: [
          Spacing.vertSmall(),
          const Divider(
            color: AppColors.secondary800,
            height: 1,
          ),
          BlocBuilder<HomeV2Bloc, HomeV2State>(builder: (context, state) {
            if (state is HomeV2LoadedState) {
              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (context, index1) {
                  return SizedBox(
                    height: 150.h,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(state.categories[index1].name),
                        ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories[index1].data.length,
                            itemBuilder: (context, index) {
                              return HomeCategoryContainer(
                                category: state.categories[index1].data[index],
                              );
                            }),
                      ],
                    ),
                  );
                },
              );
            }
            return Center(child: Text(state.toString()));
          }),
          Text(context.watch<HomeV2Bloc>().userModel?.name ?? "Name"),
          Text(context.watch<HomeV2Bloc>().appLocation?.parsedAddress ??
              "Location")
        ],
      )),
    );
  }
}
