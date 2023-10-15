import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/presentation/components/empty_plans_places_view.dart';
import 'package:funconnect/features/plans/presentation/components/friend_icon_empty_widget.dart';
import 'package:funconnect/features/plans/presentation/components/friend_icon_widget.dart';
import 'package:funconnect/features/plans/presentation/plan_details/bloc/plan_details_bloc.dart';
import 'package:funconnect/features/plans/presentation/plan_details/components/plan_place_item.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlanDetailsView extends StatelessWidget {
  final MiniPlanModel plan;
  const PlanDetailsView({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56.h,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18.w),
            child: InkWell(
              onTap: () {
                context
                    .read<PlanDetailsBloc>()
                    .add(DeletePlanClickedEvent(plan: plan));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xff202020)
                        : const Color(0xfff1f1f1)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.delete_outline_rounded,
                          color: Color(0xffff224c),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "Delete Plan",
                          style: TextStyle(
                              color: const Color(0xffff224c),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        )
                      ]),
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<PlanDetailsBloc, PlanDetailsState>(
        builder: (context, state) {
          if (state is PlanDetailsLoading) {
            return const Center(
              child: AppLoader(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  plan.description,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff999999)),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Flexible(
                  child: BlocBuilder(
                    bloc: PlanDetailsBloc()..add(PlanPlacesLoad(plan)),
                    builder: (context, state) {
                      if (state is PlanPlacesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is PlanPlacesLoaded) {
                        return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return FutureBuilder<FullPlaceModel>(
                                  future: PlanDetailsBloc().getPlaceDetails(
                                      state.places[index].placeId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Skeletonizer(
                                          child: PlanPlaceItem(
                                        plan: plan,
                                        place: snapshot.data,
                                        miniPlanPlace: state.places[index],
                                      ));
                                    }
                                    return (PlanPlaceItem(
                                        plan: plan,
                                        place: snapshot.data!,
                                        miniPlanPlace: state.places[index]));
                                  });
                            },
                            separatorBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24.h),
                                  child: const Divider(
                                    color: Color(0xff2c2c2c),
                                  ),
                                ),
                            itemCount: state.places.length);
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                EmptyPLansPlacesView(
                  onClick: () {
                    context
                        .read<PlanDetailsBloc>()
                        .add(AddAPlaceClickedEvent(plan));
                  },
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "Attendees",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 17.h,
                ),
                BlocBuilder<PlanDetailsBloc, PlanDetailsState>(
                  bloc: PlanDetailsBloc()..add(PlanFriendsLoad(plan)),
                  builder: (context, state) {
                    if (state is PlanFriendsLoading) {
                      return const CircularProgressIndicator();
                    }

                    return SizedBox(
                        height: 65.h,
                        width: double.infinity,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (state.invitedFriends?.length == null ||
                                  index == state.invitedFriends?.length) {
                                return const FriendIconEmptyWidget();
                              } else {
                                return FriendIconWidget(
                                  email:
                                      state.invitedFriends?[index].email ?? "",
                                );
                              }
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 8.w,
                                ),
                            itemCount:
                                (state.invitedFriends?.length ?? 0) + 1));
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                const AppButton(
                  label: "Save Plan",
                  borderRadius: 8,
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
