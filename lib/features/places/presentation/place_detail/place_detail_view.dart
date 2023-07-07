import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/places/presentation/place_detail/bloc/place_detail_bloc.dart';
import 'package:funconnect/features/places/presentation/place_detail/bloc/place_detail_event.dart';
import 'package:funconnect/features/places/presentation/place_detail/bloc/place_detail_state.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import 'widgets/info_section.dart';
import 'widgets/more_places_section.dart';
import 'widgets/review_section.dart';

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
                    _ImageSection(place: place),
                    Spacing.vertRegular(),
                    InfoSection(place: place),
                    const ReviewSection(),
                    Spacing.vertMedium(),
                    const MorePlacesSection(),
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

class _ImageSection extends HookWidget {
  const _ImageSection({
    required this.place,
  });

  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(409.h),
      child: Builder(
        builder: (context) {
          final state = context.watch<PlaceDetailBloc>().state;
          if (state is PlaceDetailIdleState) {
            if (state.place.images.length > 1) {
              return HookBuilder(builder: (context) {
                final controller = usePageController();
                Timer? timer;
                useEffect(() {
                  Timer.periodic(const Duration(seconds: 5), (timerr) {
                    timer = timerr;
                    if (!controller.hasClients) return;
                    if (controller.page != state.place.images.length - 1) {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.ease,
                      );
                    } else {
                      controller.jumpToPage(0);
                    }
                  });
                  return () => timer?.cancel();
                }, []);
                useListenableSelector(
                  controller,
                  () => controller.hasClients ? controller.page : 0,
                );
                return Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: PageView(
                          controller: controller,
                          children: [
                            ...state.place.images.map(
                              (e) => AppNetworkImage(
                                size: Size.fromHeight(409.h),
                                url: e.path,
                                borderRadius: 20,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (controller.hasClients && controller.page != 0)
                      Positioned(
                        left: 10,
                        top: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () => controller.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          ),
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: AppColors.black.withOpacity(.5),
                            child: Icon(
                              Icons.arrow_back,
                              size: 20.r,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    if (controller.hasClients &&
                        controller.page != state.place.images.length - 1)
                      Positioned(
                        right: 10,
                        top: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () => controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          ),
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: AppColors.black.withOpacity(.5),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 20.r,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      )
                  ],
                );
              });
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
    );
  }
}
