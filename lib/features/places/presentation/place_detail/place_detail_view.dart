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
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
                    AppButton(
                      label: "Add to plan",
                      borderRadius: 8,
                      onTap: () {
                        context
                            .read<PlaceDetailBloc>()
                            .add(AddPlaceToPlanEvent(place));
                      },
                    ),
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
    final controller = usePageController();
    return Builder(
      builder: (context) {
        final state = context.watch<PlaceDetailBloc>().state;
        if (state is PlaceDetailIdleState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 409.h,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: PageView.builder(
                  controller: controller,
                  itemCount: state.place.images.length,
                  itemBuilder: (context, index) {
                    return AppNetworkImage(
                      size: Size.fromHeight(409.h),
                      url: state.place.images[index].path,
                      placeholderWidget: AppNetworkImage(
                        url: place.coverImagePath,
                        borderRadius: 20,
                        fit: BoxFit.cover,
                        size: Size.fromHeight(409.h),
                      ),
                      borderRadius: 20,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              if (state.place.images.length > 1) ...[
                Spacing.vertRegular(),
                SmoothPageIndicator(
                  controller: controller,
                  count: state.place.images.length,
                  effect: ExpandingDotsEffect(
                    dotColor: AppColors.wGrey84,
                    activeDotColor: AppColors.primary,
                    dotHeight: 8.h,
                    dotWidth: 8.w,
                    expansionFactor: 2,
                    spacing: 4,
                  ),
                ),
              ],
            ],
          );
        }
        return AppNetworkImage(
          url: place.coverImagePath,
          borderRadius: 20,
          fit: BoxFit.cover,
          size: Size.fromHeight(409.h),
        );
      },
    );
  }
}
